//
//  WeatherViewController.m
//  天气预报
//
//  Created by 王天亮 on 2019/8/12.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import "WeatherViewController.h"
#import "ViewController.h"
#import "WeatherTableViewCell.h"
#import "SearchViewController.h"
#import "AllWeatherViewController.h"
#define url_list(n,m) @"https://free-api.heweather.net/s6/weather/now?location="#n#m
@interface WeatherViewController () <NSURLSessionDataDelegate>
@property (nonatomic, strong) NSMutableData *data;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.toolbarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImageView = [[UIImageView alloc] init];
    [self.view addSubview:backImageView];
    backImageView.frame = self.view.frame;
    [backImageView setImage:[UIImage imageNamed:@"IMG_3410.JPG"]];
    

//    ViewController *viewController = [[ViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height+40) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[WeatherTableViewCell class] forCellReuseIdentifier:@"WTLcell"];
    [self.view addSubview: self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.timeMutArray = [[NSMutableArray alloc] init];
    self.locationMutArray = [[NSMutableArray alloc] init];
    self.temperatureMutArray = [[NSMutableArray alloc] init];
     self.conditionMutArray = [[NSMutableArray alloc] init];
    
    self.didianMutArray = [[NSMutableArray alloc] init];
    [self.didianMutArray addObject:@"北京"];
//    [self.didianMutArray addObject:@"西安"];
//    [self.didianMutArray addObject:@"上海"];
    NSLog(@"地点有%@",self.didianMutArray);
    for (int i = 0; i < self.didianMutArray.count; i++) {
            [self weatherupdate:self.didianMutArray[i]];
        
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (self.locationMutArray.count == 0) {
//        return 1;
//    }

    
    return self.locationMutArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"WTLcell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
       // NSLog(@"数量为%lu",(unsigned long)self.locationMutArray.count);
    cell.timeLabel.text = self.timeMutArray[indexPath.section];
    cell.locationLabel.text = self.locationMutArray[indexPath.section];
    cell.temperatureLabel.text = self.temperatureMutArray[indexPath.section];
    return cell;
}
    
//    NSLog(@"key是%@",self.weatherMutDictionary[@"HeWeather6"][0][@"basic"][@"cid]"]);
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == self.didianMutArray.count - 1) {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    self.footButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.footButton setImage:[UIImage imageNamed:@"icon-test-3.png"] forState:UIControlStateNormal];
    self.footButton.frame = CGRectMake(self.view.frame.size.width - 60, 10, 35, 35);
    [self.footButton addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.footButton];
    return view;
    } else {
        return nil;
    }
}
- (void)sousuo {
    SearchViewController *seachViewController = [[SearchViewController alloc] init];
    seachViewController.delegate = self;
    seachViewController.didianMutArr = [[NSMutableArray alloc] init];
    seachViewController.didianMutArr = [self.didianMutArray mutableCopy];
    [self.navigationController pushViewController:seachViewController animated: YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.didianMutArray.count - 1) {
        return 300;
    } else {
        return 0;
    }
}
//跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AllWeatherViewController *all = [[AllWeatherViewController alloc] init];
    all.pageNow = indexPath.section;
    all.conditionMutArray = [[NSMutableArray alloc] init];
    all.conditionMutArray = [self.conditionMutArray mutableCopy];
    all.temperatureMutArray = [[NSMutableArray alloc] init];
     all.temperatureMutArray = [self.temperatureMutArray mutableCopy];
    all.didianMutarray = [[NSMutableArray alloc] init];
    all.didianMutarray = [self.didianMutArray mutableCopy];
    //all.tempString = self.didianMutArray[indexPath.section];
    all.locationMutarray = [[NSMutableArray alloc] init];
    all.locationMutarray = [self.didianMutArray mutableCopy];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:all];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
    
}
//收到服务器响应

- (void)passWeatherValue:(Weather *)value {
    [self.didianMutArray addObject: value.tempString];
    NSLog(@"从搜索界面传值完成");
    [self weatherupdate:self.didianMutArray[self.didianMutArray.count - 1]];
}



- (void)weatherupdate:(NSString *)string{
    NSString *tempString = [NSString stringWithFormat:@"https://free-api.heweather.net/s6/weather/now?location=%@&key=9f24a96156ad40cb9db5e064d698081e",string];
    //NSURL *url = [NSURL URLWithString:tempString];
    
   tempString = [tempString  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL*url=[NSURL URLWithString:tempString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    if (self.data == nil) {
        self.data = [[NSMutableData alloc] init];
    } else {
        self.data.length = 0;
    }
    NSLog(@"服务器响应");
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    //sleep(3);
    NSLog(@"收到信息");
    [self.data appendData:data];
}
- (NSString *)conversion:(NSString *)string {
    string = [string substringFromIndex:11];
    return string;
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error == nil) {
        NSLog(@"准备接收数据");
        self.weatherMutDictionary = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
       
        NSLog(@"%@",self.weatherMutDictionary);
        if ([self.weatherMutDictionary[@"HeWeather6"][0][@"status"] isEqual:@"unknown location"] || [self.weatherMutDictionary[@"HeWeather6"][0][@"status"] isEqual:@"invalid param"]) {
            [self.didianMutArray removeObjectAtIndex: self.didianMutArray.count - 1];
            //如果城市不存在
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 200 , 150, 50)];
            tempLabel.text = @"城市不存在";
            tempLabel.font = [UIFont systemFontOfSize:24];
            [self.view addSubview:tempLabel];
            tempLabel.textColor = [UIColor whiteColor];
            tempLabel.alpha = 0;
            [UIView animateWithDuration:3 animations:^{
                tempLabel.alpha = 0.8;
            }];
            
            [UIView animateWithDuration:3 animations:^{
                tempLabel.alpha = 0;
            }];

            
        } else {
        
         [self.timeMutArray addObject: [self conversion:self.weatherMutDictionary[@"HeWeather6"][0][@"update"][@"loc"]]];
        
        [self.locationMutArray addObject:self.weatherMutDictionary[@"HeWeather6"][0][@"basic"][@"location"]];
        
        [self.temperatureMutArray addObject:self.weatherMutDictionary[@"HeWeather6"][0][@"now"][@"fl"]];
        
      
        [self.conditionMutArray addObject: self.weatherMutDictionary[@"HeWeather6"][0][@"now"][@"cond_txt"]];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_tableView reloadData];
        });
        //dispatch_async(dispatch_get_main_queue(), ^{
         //   [self->_tableView reloadData];
        //});
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
