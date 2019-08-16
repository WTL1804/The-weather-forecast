//
//  Weather.h
//  天气预报
//
//  Created by 王天亮 on 2019/8/14.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class  Weather;
@protocol weatherDelegate <NSObject>

- (void)passWeatherValue: (Weather *)value;

@end
@interface Weather : NSObject
@property (nonatomic, copy)  NSString *tempString;
@end

NS_ASSUME_NONNULL_END
