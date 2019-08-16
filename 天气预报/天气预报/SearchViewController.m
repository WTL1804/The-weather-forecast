//
//  SearchViewController.m
//  天气预报
//
//  Created by 王天亮 on 2019/8/13.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import "SearchViewController.h"
#import "WeatherViewController.h"
#import "KongTableViewCell.h"

@interface SearchViewController () <UITextFieldDelegate, NSURLSessionDataDelegate>
@property (nonatomic, strong) NSMutableData *data;

@end

@implementation SearchViewController

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
    [backImageView setImage:[UIImage imageNamed:@"IMG_3412.JPG"]];
    
    
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 95, 350, 60)];
    [self.view addSubview:self.searchTextField];
    self.searchTextField.keyboardType = UIKeyboardTypeDefault;
//    [self.searchTextField addTarget:self action:@selector(search) forControlEvents:UIControlEventEditingDidEnd];
    self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTextField.layer.borderColor = [[UIColor  whiteColor]CGColor];
    self.searchTextField.layer.borderWidth = 3;
    self.searchTextField.delegate = self;
    self.searchTextField.placeholder = @"输入城市以搜索";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 155, self.view.frame.size.width, self.view.frame.size.height - 155) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[KongTableViewCell class] forCellReuseIdentifier:@"123"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.searchTextField addTarget:self action:@selector(search) forControlEvents:UIControlEventEditingChanged];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:self.tableView];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 300, 30)];
    self.label.text = @"天气已经添加或不能添加为空";
     self.label.alpha = 0;
    [self.view addSubview: self.label];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityMutArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KongTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"123" forIndexPath:indexPath];
    cell.cityLabel.text = self.cityMutArr[indexPath.section];
    cell.cityLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.cityLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.searchTextField.text = self.cityMutArr[indexPath.section];
    [self.searchTextField reloadInputViews];

}

- (void)search {
    self.tempString = self.searchTextField.text;
    [self updata];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    Weather *value = [[Weather alloc] init];
    int flag = 0;
    for (int i = 0; i < self.didianMutArr.count; i++) {
        if ([self.searchTextField.text isEqual: self.didianMutArr[i]] || [self.searchTextField.text isEqual: @""]){
            flag++;
            break;
        }
    }
    if (flag  == 0) {
        value.tempString = self.searchTextField.text;
        
    NSLog(@"%@",self.searchTextField.text);
    [self.delegate passWeatherValue:value];
    [self.navigationController popViewControllerAnimated:YES];
    } else {
        [UIView animateWithDuration:1.5 animations:^{
            self.label.alpha = 0.8;
        }];
        [UIView animateWithDuration:1 animations:^{
            self.label.alpha = 0;
        }];
    
    }
    return YES;
}
- (void)updata {
        NSString *string = @"https://search.heweather.net/find?";
        NSString *string2 = [NSString stringWithFormat:@"location=%@&key=93b30a881ab84f1eb7620927185f49f4", self.tempString];
        
        string = [string  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString: string];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [string2 dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            self.weatherDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
             // NSLog(@"%@",self.cityMutArr);
            self.cityMutArr = [[NSMutableArray alloc] init];
           // NSLog(@"%@",self.weatherDict);
            if ([self.weatherDict[@"HeWeather6"][0][@"status"] isEqual:@"unknown location"] || [self.weatherDict[@"HeWeather6"][0][@"status"] isEqual:@"invalid param"]) {
                ;
            } else {
                for (NSDictionary *dict in self.weatherDict[@"HeWeather6"][0][@"basic"]) {
                    NSString *string = dict[@"location"];
                    //NSLog(@"%@",string);
                    [self.cityMutArr addObject:string];
                }
            }
                
            dispatch_async(dispatch_get_main_queue(), ^{
              //  if (![self.weatherDict isKindOfClass:[NSNull class]] && ![self.weatherDict isEqual:[NSNull null]]) {
                
             //   }
                [self.tableView reloadData];
                
            });
        }];
        [dataTask resume];

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section { return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;

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
