//
//  SearchViewController.h
//  天气预报
//
//  Created by 王天亮 on 2019/8/13.
//  Copyright © 2019 王天亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITextField *searchTextField;
@property NSObject <weatherDelegate>*delegate;
@property (nonatomic, strong) NSMutableDictionary *weatherDict;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *tempString;
@property (nonatomic, strong) NSMutableArray *cityMutArr;
@property (nonatomic, strong) NSMutableArray *didianMutArr;
@property NSInteger flag;
@property (nonatomic, strong) UILabel *label;
@end

NS_ASSUME_NONNULL_END
