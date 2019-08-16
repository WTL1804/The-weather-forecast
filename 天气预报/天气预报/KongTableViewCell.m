//
//  KongTableViewCell.m
//  天气预报
//
//  Created by 王天亮 on 2019/8/15.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import "KongTableViewCell.h"

@implementation KongTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.cityLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.cityLabel];
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.cityLabel.frame = CGRectMake(4, 5, 300, 60);
}
@end
