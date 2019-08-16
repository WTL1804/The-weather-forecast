//
//  GeneralTableViewCell.h
//  天气预报
//
//  Created by 王天亮 on 2019/8/13.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *forecastDataLabel;
@property (nonatomic, strong) UILabel *forecastTopLabel;
@property (nonatomic, strong) UILabel *forecastMinLabel;

@property (nonatomic, strong) UIImageView *forecastImageView;

@property (nonatomic, strong) UILabel *describeLeftLabel;
@property (nonatomic, strong) UILabel *describeRightLabel;
@property (nonatomic, strong) UILabel *contentLeftLabel;
@property (nonatomic, strong) UILabel *contentRightLabel;
@end

NS_ASSUME_NONNULL_END
