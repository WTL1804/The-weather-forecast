//
//  WeatherViewController.h
//  天气预报
//
//  Created by 王天亮 on 2019/8/12.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeatherViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,weatherDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *locationMutArray;
@property (nonatomic, strong) NSMutableArray *timeMutArray;
@property (nonatomic, strong) NSMutableArray *temperatureMutArray;
@property (nonatomic, strong) NSMutableDictionary *weatherMutDictionary;
@property (nonatomic, strong) NSMutableArray *allWeatherMutDict;
@property (nonatomic, strong) UIButton *footButton;
@property (nonatomic, copy) NSString *tempString;
@property (nonatomic, strong) NSMutableArray *didianMutArray;
@property (nonatomic, strong) NSMutableArray *conditionMutArray;
@end

NS_ASSUME_NONNULL_END
