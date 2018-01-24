//
//  BLCourseListModel.h
//  BLTreeTableView
//
//  Created by Balopy on 2017/12/20.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BLListType) {
    courseType = 0,
    chapterType,
    parterType,
    fourthType,
    fiveType
};
@interface BLCourseListModel : NSObject

@property (nonatomic, copy) NSString *courseName;
@property (nonatomic, copy) NSString *chapterName;
@property (nonatomic, copy) NSString *partName;
@property (nonatomic, assign) NSUInteger courseId;
@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, strong) NSArray *subList;


@property (nonatomic , assign) BLListType depth;//该节点的深度

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态


@end
