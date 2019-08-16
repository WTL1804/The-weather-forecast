//
//  WeatherTableViewCell.h
//  天气预报
//
//  Created by 王天亮 on 2019/8/12.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;

@end

NS_ASSUME_NONNULL_END
