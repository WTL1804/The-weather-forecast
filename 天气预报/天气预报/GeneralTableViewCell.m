//
//  GeneralTableViewCell.m
//  天气预报
//
//  Created by 王天亮 on 2019/8/13.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import "GeneralTableViewCell.h"

@implementation GeneralTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.forecastDataLabel = [[UILabel alloc] init];
    [self.contentView addSubview: self.forecastDataLabel];
    self.forecastDataLabel.textColor = [UIColor whiteColor];
    
    self.forecastTopLabel = [[UILabel alloc] init];
    [self.contentView addSubview: self.forecastTopLabel];
    self.forecastTopLabel.textColor = [UIColor whiteColor];
    
    
    self.forecastMinLabel = [[UILabel alloc] init];
    [self.contentView addSubview: self.forecastMinLabel];
    self.forecastMinLabel.textColor = [UIColor whiteColor];
    
    
    self.forecastImageView = [[UIImageView alloc] init];
    [self.contentView addSubview: self.forecastImageView];
    
    
    
    self.describeLeftLabel = [[UILabel alloc] init];
    [self.contentView addSubview: self.describeLeftLabel];
    self.describeLeftLabel.textColor = [UIColor whiteColor];
    
    
    self.describeRightLabel = [[UILabel alloc] init];
    [self.contentView addSubview: self.describeRightLabel];
    self.describeRightLabel.textColor = [UIColor whiteColor];
    
    self.contentLeftLabel = [[UILabel alloc] init];
    [self.contentView addSubview: self.contentLeftLabel];
    self.contentLeftLabel.textColor = [UIColor whiteColor];
    
    self.contentRightLabel = [[UILabel alloc] init];
    [self.contentView addSubview: self.contentRightLabel];
    self.contentRightLabel.textColor = [UIColor whiteColor];
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.forecastDataLabel.frame = CGRectMake(5, 10, 100, 30);
    self.forecastTopLabel.frame = CGRectMake(414 - 120, 10, 50, 30);
    self.forecastMinLabel.frame = CGRectMake(414 - 70, 10, 50, 30);
    self.forecastImageView.frame = CGRectMake(200, 10, 35, 35);
    
    self.describeRightLabel.frame = CGRectMake(414 - 120, 5, 100, 35);
    self.describeLeftLabel.frame = CGRectMake(50, 5, 100, 35);
    self.contentLeftLabel.frame = CGRectMake(50, 50, 100, 35);
    self.contentRightLabel.frame = CGRectMake(414 - 120, 50, 100, 35);
}
@end
