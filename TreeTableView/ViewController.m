//
//  ViewController.m
//  BLTreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "ViewController.h"
#import "BLTreeTableView.h"
#import "BLCourseListModel.h"
#import "YYModel.h"


@interface ViewController ()<BLTreeTableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
}
- (void) initData {
    
    NSArray *tempArr = [NSArray yy_modelArrayWithClass:[BLCourseListModel class] json:[self getArrayWithType]];
    
    BLTreeTableView *tableview = [[BLTreeTableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20) withData:tempArr];
    
    tableview.treeDelegate = self;
    
    [self.view addSubview:tableview];
}


#pragma mark - cell 的代理方法
-(void)didSelectedForRowClick:(BLCourseListModel *)node {
    
    NSLog(@"%@",node.courseName);
    
}
#pragma mark -- 原理， 就是使用数组与字典的嵌套，无限嵌套，然后给 TableView 赋值--
- (NSArray *) getArrayWithType {
    
    NSMutableArray *dataArray = @[].mutableCopy;
    
    //第一级
    for (NSUInteger course = 0; course < 5; course ++) {
        NSMutableDictionary *dict_course = [self getDictionaryParentId:0 ID:course];
        
        NSMutableArray *chapterArr = @[].mutableCopy;
        
        //第二级
        for (NSUInteger chap = 0; chap < 5; chap ++) {
            
            NSMutableDictionary *dict_chapter = [self getDictionaryParentId:course ID:chap];
            
            NSMutableArray *partArr = @[].mutableCopy;
            
            //第三级
            for (NSUInteger part = 0; part < 5; part ++) {
                NSMutableDictionary *dict_part = [self getDictionaryParentId:chap ID:part];
                
                NSMutableArray *forthArr = @[].mutableCopy;
                for (int forth = 0; forth < 5; forth ++) {
                    NSMutableDictionary *dict_forth = [self getDictionaryParentId:part ID:forth];

                    
                    NSMutableArray *fiveArr = @[].mutableCopy;
                    for (int five = 0; five < 5; five ++) {
                      
                        NSMutableDictionary *dict_five = [self getDictionaryParentId:forth ID:five];
                        [dict_five setValue:@(fiveType) forKey:@"depth"];
                        [fiveArr addObject:dict_five];
                    }
                    
                    [dict_forth setValue:@(fourthType) forKey:@"depth"];
                    [dict_forth setValue:fiveArr forKey:@"subList"];
                    [forthArr addObject:dict_forth];
                }
                
                [dict_part setValue:forthArr forKey:@"subList"];
                [dict_part setValue:@(parterType) forKey:@"depth"];
                [partArr addObject:dict_part];
            }
            
            [dict_chapter setValue:partArr forKey:@"subList"];
            [dict_chapter setValue:@(chapterType) forKey:@"depth"];
            [chapterArr addObject:dict_chapter];
        }
        
        [dict_course setValue:@(courseType) forKey:@"depth"];
        
        [dict_course setValue:chapterArr forKey:@"subList"];
        [dataArray addObject:dict_course];
    }
    
    return dataArray;
}

- (NSMutableDictionary *) getDictionaryParentId:(NSUInteger)parentId ID:(NSUInteger)Id
{
    
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    
    
    
    [dict setValue:[NSString stringWithFormat:@"课程---%lu---", parentId] forKey:@"courseName"];
    [dict setValue:[NSString stringWithFormat:@"第--(%lu)--章", Id] forKey:@"chapterName"];
    [dict setValue:[NSString stringWithFormat:@"第-(%lu)-节", Id] forKey:@"partName"];
    [dict setValue:@(parentId) forKey:@"courseId"];
    [dict setValue:@(Id) forKey:@"ID"];
    [dict setValue:@[] forKey:@"subList"];
    [dict setValue:@(0) forKey:@"depth"];
    [dict setValue:@(NO) forKey:@"expand"];
    
    return dict;
}

@end
