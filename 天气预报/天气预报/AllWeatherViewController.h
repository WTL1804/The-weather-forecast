//
//  AllWeatherViewController.h
//  天气预报
//
//  Created by 王天亮 on 2019/8/13.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllWeatherViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *topMutarray;
@property (nonatomic, strong) NSMutableArray *minMutarray;
@property (nonatomic, strong) NSMutableArray *timeMutarray;
@property (nonatomic, strong) NSMutableArray *locationMutarray;
@property (nonatomic, strong) NSMutableArray *didianMutarray;
@property (nonatomic, strong) NSMutableArray *temperatureMutArray;
@property (nonatomic, strong) NSMutableArray *conditionMutArray;
@property (nonatomic, strong) NSMutableArray *contentLeftMutArray;
@property (nonatomic, strong) NSMutableArray *contentRightMutArray;
@property (nonatomic, strong) NSMutableArray *tempMutarray;
@property (nonatomic, strong) NSMutableArray *forecastMutArr;
@property (nonatomic, strong) NSMutableArray *condForeMutArr;
@property (nonatomic, strong) NSMutableArray *timeForeMutArr;


@property (nonatomic, strong) NSMutableDictionary *weatherMutDict;
@property (nonatomic, strong) NSMutableDictionary *forecastDict;


@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *conditionLabel;

@property (nonatomic, strong) UIButton *footButton;

@property (nonatomic, copy) NSArray *describeLeftArray;
@property (nonatomic, copy) NSArray *describeRightArray;

@property (nonatomic, copy) NSString *tempString;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) NSInteger temp;
@property (nonatomic, assign) NSInteger flagForecast;
@property (nonatomic, assign) NSInteger pageNow;

@property (nonatomic, strong) UIPageControl *pageControl;



@end

NS_ASSUME_NONNULL_END
