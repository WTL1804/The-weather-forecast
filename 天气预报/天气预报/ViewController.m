//
//  ViewController.m
//  天气预报
//
//  Created by 王天亮 on 2019/8/12.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import "ViewController.h"
#import "WeatherViewController.h"
#define url_list(n,m) @"https://free-api.heweather.net/s6/weather/now?location="#n#m
@interface ViewController () <NSURLSessionDataDelegate>
@property (nonatomic, strong) NSMutableData *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.toolbarHidden = NO;
    self.view.userInteractionEnabled = YES;
    [self reload];
//    WeatherViewController *weatherView = [[WeatherViewController alloc] init];
//    [weatherView.timeMutArray addObject:self.weatherMutDictionary[@"HeWeather6"][0][@"update"][@"loc"]];
//    [weatherView.locationMutArray addObject:self.weatherMutDictionary[@"HeWeather6"][0][@"basic"][@"cid"]];
//    [weatherView.temperatureMutArray addObject:self.weatherMutDictionary[@"HeWeather6"][0][@"now"][@"fl"]];
//
//    [self.navigationController pushViewController:weatherView animated:NO];
    
}

//    NSEnumerator *enumtorkey = [self.weatherMutDictionary keyEnumerator];
//    NSLog(@"key是%@",self.weatherMutDictionary[@"HeWeather6"][0][@"basic"][@"cid"]);
- (void)reload {
    self.locationMutArray = [[NSMutableArray alloc] init];
    [self.locationMutArray addObject:@"beijing"];
    NSString *string = [NSString stringWithFormat:@"https://free-api.heweather.net/s6/weather/now?location=%@&key=93b30a881ab84f1eb7620927185f49f4",self.locationMutArray[0]];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
   NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    self.didianMutArray = [[NSMutableArray alloc] init];
    [self.didianMutArray addObject:@"beijing"];
    [dataTask resume];
}
//接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    if (self.data == nil) {
        self.data = [[NSMutableData alloc] init];
    } else {
        self.data.length = 0;
    }
    
    NSLog(@"didreceiveResponse");
    completionHandler(NSURLSessionResponseAllow);
}
//接收到数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"didreceivedata");
    [self.data appendData:data];

}
- (NSString *)conversion: (NSString *)string{
    //11 ~15
    string = [string substringFromIndex:11];
    return string;
}
//数据请求完成，或者请求出现错误调用的方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"didicompleteWithError");
    if (error == nil) {
        //解析数据
        self.weatherMutDictionary = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",self.weatherMutDictionary);
        NSLog(@"123");
        WeatherViewController *weatherView = [[WeatherViewController alloc] init];
        weatherView.timeMutArray = [[NSMutableArray alloc] init];
        weatherView.locationMutArray = [[NSMutableArray alloc] init];
        weatherView.temperatureMutArray = [[NSMutableArray alloc] init];
        
        
       [weatherView.timeMutArray addObject: [self conversion:self.weatherMutDictionary[@"HeWeather6"][0][@"update"][@"loc"]]];
        
        [weatherView.locationMutArray addObject:self.weatherMutDictionary[@"HeWeather6"][0][@"basic"][@"admin_area"]];
        
        [weatherView.temperatureMutArray addObject:self.weatherMutDictionary[@"HeWeather6"][0][@"now"][@"fl"]];
        
        weatherView.conditionMutArray = [[NSMutableArray alloc] init];
        [weatherView.conditionMutArray addObject: self.weatherMutDictionary[@"HeWeather6"][0][@"now"][@"cond_txt"]];
        weatherView.didianMutArray = [self.didianMutArray mutableCopy];
        [self.navigationController pushViewController:weatherView animated:NO];
    }
}
@end
