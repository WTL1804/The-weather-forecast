//
//  AllWeatherViewController.m
//  天气预报
//
//  Created by 王天亮 on 2019/8/13.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import "AllWeatherViewController.h"
#import "GeneralTableViewCell.h"
@interface AllWeatherViewController () <NSURLSessionDataDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableData *data;
@end

@implementation AllWeatherViewController

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
    [backImageView setImage:[UIImage imageNamed:@"IMG_3411.JPG"]];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height-20)];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.didianMutarray.count,0);
    self.scrollView.contentOffset = CGPointMake(self.pageNow * self.view.frame.size.width, 0);
    self.scrollView.delegate = self;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height+80) style:UITableViewStyleGrouped];
    [self.scrollView addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[GeneralTableViewCell class] forCellReuseIdentifier:@"Wtlcell"];
    self.tableView.tag = 100;
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    
    self.tableView.tableHeaderView = self.headImageView;
    
    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 130, 200, 80)];
    self.headLabel.font = [UIFont systemFontOfSize:35];
    NSLog(@"%@",self.locationMutarray[0]);
    self.headLabel.textAlignment = NSTextAlignmentCenter;
   
    [self.headImageView addSubview:self.headLabel];
    
    self.temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 170, 100, 80)];
    self.temperatureLabel.font = [UIFont systemFontOfSize:45];
   
    self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
    [self.headImageView addSubview:self.temperatureLabel];
    
    self.conditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 220, 100, 80)];
    self.conditionLabel.font = [UIFont systemFontOfSize:30];
    
    self.conditionLabel.textAlignment = NSTextAlignmentCenter;
    [self.headImageView addSubview:self.conditionLabel];
    self.headLabel.tag = 50;
    self.scrollView.pagingEnabled = YES;
    self.flagForecast = 0;
    self.headLabel.textColor = [UIColor whiteColor];
    self.conditionLabel.textColor = [UIColor whiteColor];
    self.temperatureLabel.textColor = [UIColor whiteColor];
    
    self.footButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.footButton setImage:[UIImage imageNamed:@"icon-test-3.png"] forState:UIControlStateNormal];
    self.footButton.frame = CGRectMake(self.view.frame.size.width - 65, self.view.frame.size.height - 35, 35, 35);
    [self.footButton addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.footButton];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(180, self.view.frame.size.height - 35, 35, 35)];
    self.pageControl.numberOfPages = self.didianMutarray.count;
    self.pageControl.currentPage = self.pageNow;
    self.headLabel.text = self.locationMutarray[0];
    [self.view addSubview: self.pageControl];
    
    
    //增加的tableView
    for (int i = 1; i < self.didianMutarray.count; i++) {
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, -40, self.view.frame.size.width, self.view.frame.size.height+80) style:UITableViewStyleGrouped];
        [self.scrollView addSubview:tempTableView];
        tempTableView.backgroundColor = [UIColor clearColor];
        [tempTableView registerClass:[GeneralTableViewCell class] forCellReuseIdentifier:@"Wtlcell"];
        tempTableView.delegate = self;
        tempTableView.dataSource = self;
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        tempTableView.tag = i + 100;
        tempTableView.tableHeaderView = headImageView;
        
        
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 130, 200, 80)];
        headLabel.font = [UIFont systemFontOfSize:35];
        headLabel.textAlignment = NSTextAlignmentCenter;
        headLabel.tag = 50 + i;
        headLabel.textColor = [UIColor whiteColor];
        headLabel.text = self.locationMutarray[i];
        [headImageView addSubview:headLabel];
        
        
        UILabel  *temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 170, 100, 80)];
        temperatureLabel.font = [UIFont systemFontOfSize:45];
        
        temperatureLabel.textAlignment = NSTextAlignmentCenter;
        [headImageView addSubview: temperatureLabel];
        temperatureLabel.textColor = [UIColor whiteColor];
        
       UILabel  *conditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 220, 100, 80)];
        conditionLabel.font = [UIFont systemFontOfSize:30];
        conditionLabel.textColor = [UIColor whiteColor];
        
        
        conditionLabel.textAlignment = NSTextAlignmentCenter;
        [headImageView addSubview:conditionLabel];
        temperatureLabel.text = self.temperatureMutArray[i];
       // headLabel.text = self.locationMutarray[i];
        conditionLabel.text = self.conditionMutArray[i - 1];
    }
    
    

    
    self.describeLeftArray = [NSArray arrayWithObjects:@"",@"日出",@"降雨概率",@"风",@"降水量",@"能见度", nil];
    self.describeRightArray = [NSArray arrayWithObjects:@"",@"日落",@"湿度",@"体感温度",@"气压",@"紫外线指数", nil];
   self.locationMutarray = [[NSMutableArray alloc] init];
    self.forecastDict = [[NSMutableDictionary alloc] init];
    self.forecastMutArr = [[NSMutableArray alloc] init];
    self.condForeMutArr = [[NSMutableArray alloc] init];
    self.timeForeMutArr = [[NSMutableArray alloc] init];
    NSLog(@"%@",self.locationMutarray);
    self.flag = 100;
    self.temp = 50;
        self.temperatureLabel.text = self.temperatureMutArray[0];
    self.conditionLabel.text = self.conditionMutArray[0];
    for (int i = 0; i < self.didianMutarray.count; i++) {
        [self dataRequest:self.didianMutarray[i]];
        [self twentyForecast: self.didianMutarray[i]];
    }
    //[self twentyForecast: self.didianMutarray[0]];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 1;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   NSInteger x = self.scrollView.contentOffset.x ;
    x = x / self.view.frame.size.width;
    //NSLog(@"%f",self.scrollView.contentOffset.x);
    self.pageControl.currentPage = x;
    //[self.pageControl reloadInputViews];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Wtlcell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.section == 0 && self.flag == 100 + _didianMutarray.count) {
        cell.forecastDataLabel.text = self.timeMutarray[indexPath.row + (tableView.tag - 100) * 3];
        
        cell.forecastTopLabel.text = self.topMutarray[indexPath.row + (tableView.tag - 100) * 3];
        
        cell.forecastMinLabel.text = self.minMutarray[indexPath.row + (tableView.tag - 100) * 3];
        
        [cell.forecastImageView setImage:[UIImage imageNamed:@"duoyun.png"]];
    } else if (indexPath.section != 0 && self.flag == 100 + _didianMutarray.count){
        cell.describeRightLabel.text = self.describeRightArray[indexPath.section];
        cell.describeLeftLabel.text = self.describeLeftArray[indexPath.section];
        cell.contentLeftLabel.text = self.contentLeftMutArray[indexPath.section - 1 + (tableView.tag - 100) * 5];
        cell.contentRightLabel.text = self.contentRightMutArray[indexPath.section - 1 + (tableView.tag - 100) * 5];
    
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else {
        return 80;
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 && self.flagForecast == self.didianMutarray.count) {
        UIScrollView *headScrollView = [[UIScrollView alloc] init];
        headScrollView.contentSize = CGSizeMake(self.view.frame.size.width *5, 0);
        //headScrollView.backgroundColor = [UIColor orangeColor];
        for (int i = 0; i < 23; i++) {
        UILabel *timeForecastLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * i + 10, 5, 80, 30)];
            UIImageView *condForecastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100 * i + 20, 40, 40, 30)];
            UILabel *tempForecastLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * i + 20, 80, 80, 35)];
            [headScrollView addSubview:timeForecastLabel];
            [headScrollView addSubview:condForecastImageView];
            [headScrollView addSubview:tempForecastLabel];
            tempForecastLabel.textColor = [UIColor whiteColor];
            timeForecastLabel.textColor = [UIColor whiteColor];
            
            
            
            tempForecastLabel.text = self.forecastMutArr[i + (tableView.tag -100) * 23];
            NSString *stringFore = [NSString stringWithFormat:@"%@.png",self.condForeMutArr[i + (tableView.tag -100) * 23]];
            UIImage *image = [UIImage imageNamed:stringFore];
            [condForecastImageView setImage: image];
            timeForecastLabel.text = self.timeForeMutArr[i + (tableView.tag -100) * 23];
        }

        return headScrollView;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 110;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return 100;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (section == 5) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 450, 100)];
//        view.backgroundColor = [UIColor clearColor];
//        self.footButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.footButton setImage:[UIImage imageNamed:@"icon-test-3.png"] forState:UIControlStateNormal];
//        self.footButton.frame = CGRectMake(self.view.frame.size.width - 60, 10, 35, 35);
//        [self.footButton addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:self.footButton];
//        return view;
//    }
    return nil;
}
- (NSString *)conversion:(NSString *)string {
    string = [string substringFromIndex:11];
    string = [string substringToIndex:5];
    return string;
}
//24小时预报
//https://sapi.k780.com/?app=weather.realtime&weaid=%@&ag=futureHour&appkey=44507&sign=6eeff5ea116a0150974ef3e9966c06f7&format=json
- (void)twentyForecast:(NSString *)flagString {
    NSString *string = @"https://sapi.k780.com/";
    NSString *string2 = [NSString stringWithFormat:@"app=weather.realtime&weaid=%@&ag=futureHour&appkey=44507&sign=6eeff5ea116a0150974ef3e9966c06f7&format=json", flagString];
    
    string = [string  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString: string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [string2 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.forecastDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.flagForecast++;
      //  NSLog(@"预报是%lu",self.flagForecast);
        NSLog(@"%@",self.forecastDict);
        
        if ([self.forecastDict[@"success"] isEqual:@"0"]) {
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
        
        
        
        for (int i = 0; i < 23; i++) {
            [self.forecastMutArr addObject: self.forecastDict[@"result"][@"futureHour"][i][@"wtTemp"]];
            [self.timeForeMutArr addObject: [self  conversion : self.forecastDict[@"result"][@"futureHour"][i][@"dateYmdh"]]];
            [self.condForeMutArr addObject:self.forecastDict[@"result"][@"futureHour"][i][@"wtIcon"]];
        }
    }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.flagForecast == self.didianMutarray.count) {
                for (int i = 100; i  < 100 + self.didianMutarray.count; i++){
                    UITableView *tableView = [self.view viewWithTag:i];
                    [tableView reloadData];
                }
            }
        });
        
        
        
    }];
    [dataTask resume];
}





- (void)sousuo {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)dataRequest:(NSString *)flagString {
    NSString *string = [NSString stringWithFormat:@"https://free-api.heweather.net/s6/weather/forecast?location=%@&key=9f24a96156ad40cb9db5e064d698081e",flagString];

    
    string = [string  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString: string];

    
    
  //  NSURL *url = [NSURL URLWithString: string];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    if (self.data == nil) {
        self.data = [[NSMutableData alloc] init];
    } else {
        self.data.length = 0;
    }
    NSLog(@"收到服务器响应");
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"收到信息");
    
    [self.data appendData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"接收完毕");
    if (error == nil) {
        self.weatherMutDict = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
        
        self.tempMutarray = [[NSMutableArray alloc] init];
//        [self.tempMutarray addObject: self.weatherMutDict[@"HeWeather6"][0][@"basic"][@"admin_area"]];
        if (self.timeMutarray == nil) {
        self.timeMutarray = [[NSMutableArray alloc] init];
        self.topMutarray = [[NSMutableArray alloc] init];
        self.minMutarray = [[NSMutableArray alloc] init];
        }
        NSLog(@"%@",self.weatherMutDict);
        
        if ([self.forecastDict[@"success"] isEqual:@"0"] || self.weatherMutDict == NULL) {
            //如果城市不存在
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 400 , 150, 50)];
            tempLabel.text = @"请求失败，请重试";
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
        
        
        
            for (int i = 0; i < 3; i++) {
            //最高气温
                [self.topMutarray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][i][@"tmp_max"]];
            //最低气温
                [self.minMutarray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][i][@"tmp_min"]];
            //预测日期
                [self.timeMutarray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][i][@"date"]];
            
            }
        
        //气温
        //地点拼音
        
        //地点代码
       // NSLog(@"地点是%@",self.weatherMutDict[@"HeWeather6"][0][@"basic"][@"location"]);
        [self.locationMutarray
         addObject:self.weatherMutDict[@"HeWeather6"][0][@"basic"][@"location"]];
    
        //天气状况
        if (self.contentLeftMutArray == nil) {
            self.contentRightMutArray = [[NSMutableArray alloc] init];
            self.contentLeftMutArray = [[NSMutableArray alloc] init];
        }
        //左边描述
        
        [self.contentLeftMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"sr"]];
        [self.contentLeftMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"pop"]];
        [self.contentLeftMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_spd"]];
        [self.contentLeftMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"pcpn"]];
        [self.contentLeftMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"vis"]];
        
        //右边描述
 
        [self.contentRightMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"ss"]];
        [self.contentRightMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"hum"]];
        [self.contentRightMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"]];
        [self.contentRightMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"pres"]];
        [self.contentRightMutArray addObject: self.weatherMutDict[@"HeWeather6"][0][@"daily_forecast"][0][@"uv_index"]];
//
        //self.headLabel.text = self.locationMutarray[0];
        
        NSLog(@"didian%@",self.didianMutarray);
        dispatch_async(dispatch_get_main_queue(), ^{
           self.flag++;
            self.temp++;
            if (self.flag == 100 + self.didianMutarray.count) {
                for (int i = 100; i  < 100 + self.didianMutarray.count; i++){
                    UITableView *tableView = [self.view viewWithTag:i];
                    [tableView reloadData];
                }
                //NSLog(@"地点：%@",self.locationMutarray);
//                for (int i = 50; i < 50 + self.didianMutarray.count; i++) {
//               UILabel *label = [self.view viewWithTag: i];
//                    label.text = self.locationMutarray[i-50];
//                }
            }
        });
        
    }
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
