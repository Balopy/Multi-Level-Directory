//
//  BLCourseListModel.m
//  BLTreeTableView
//
//  Created by Balopy on 2017/12/20.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#import "BLCourseListModel.h"
#import "YYModel.h"
@implementation BLCourseListModel
- (void)setSubList:(NSArray *)subList {
    _subList = [NSArray yy_modelArrayWithClass:[BLCourseListModel class] json:subList];
}
@end
