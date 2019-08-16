//
//  WeatherTableViewCell.m
//  天气预报
//
//  Created by 王天亮 on 2019/8/12.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.textColor = [UIColor whiteColor];
    
    self.locationLabel = [[UILabel alloc] init];
    [self.contentView addSubview: self.locationLabel];
    self.locationLabel.textColor = [UIColor whiteColor];
    
    self.temperatureLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.temperatureLabel];
    self.temperatureLabel.textColor = [UIColor whiteColor];
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.timeLabel.frame = CGRectMake(3, 25, 150, 30);
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    
    self.locationLabel.frame = CGRectMake(3, 40, 300, 60);
    self.locationLabel.font = [UIFont systemFontOfSize:20];
    self.temperatureLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 15, 100, 80);
    self.temperatureLabel.font = [UIFont systemFontOfSize:28];
}
@end
