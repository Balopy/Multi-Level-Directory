//
//  BLTreeTableView.h
//  BLTreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BLCourseListModel;

@protocol BLTreeTableViewDelegate <NSObject>

-(void)didSelectedForRowClick:(BLCourseListModel *)node;

@end

@interface BLTreeTableView : UITableView

@property (nonatomic , weak) id<BLTreeTableViewDelegate> treeDelegate;

-(instancetype)initWithFrame:(CGRect)frame withData : (NSArray *)data;

@end
