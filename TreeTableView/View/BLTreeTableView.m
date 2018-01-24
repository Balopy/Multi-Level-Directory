//
//  BLTreeTableView.m
//  BLTreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "BLTreeTableView.h"
#import "BLTreeTableViewCell.h"
#import "BLCourseListModel.h"

@interface BLTreeTableView ()<UITableViewDataSource,UITableViewDelegate>

/*! 用于存储数据源 */
@property (nonatomic , strong) NSMutableArray *tempData;


@end

@implementation BLTreeTableView

-(instancetype)initWithFrame:(CGRect)frame withData : (NSArray *)data{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self)
    {
        self.dataSource = self;
        self.delegate = self;
        _tempData = data.mutableCopy;
    }
    return self;
}



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NODE_CELL_ID = @"node_cell_id";
    
    BLBLTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell)
    {
        cell = [[BLBLTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NODE_CELL_ID];
    }
    
    BLCourseListModel *node = [_tempData objectAtIndex:indexPath.row];
    cell.node = node;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //先修改数据源
    BLCourseListModel *parentNode = [_tempData objectAtIndex:indexPath.row];
    
    if (_treeDelegate && [_treeDelegate respondsToSelector:@selector(didSelectedForRowClick:)]) {
        [_treeDelegate didSelectedForRowClick:parentNode];
    }
    //计算开始插入数的位置
    NSUInteger startPosition = indexPath.row+1;
    //开始插入位置并累加
    NSUInteger endPosition = startPosition;
    BOOL expand = NO;
    
    parentNode.expand = !parentNode.expand; //折叠与否
    NSArray *chapterArr = parentNode.subList;//取出章
   
    if (parentNode.expand) {//展开
        
        for (int k = 0; k < chapterArr.count; k ++) {
            
            BLCourseListModel *chapterNode = [chapterArr objectAtIndex:k];//到出子节
            
            [_tempData insertObject:chapterNode atIndex:endPosition];
            
            expand = YES;//如果有爹，且有儿子，则可以展开
            endPosition++;
        }
    } else {//折叠
        
        endPosition = [self removeAllNodesAtParentNode:parentNode];
    }

    //获得需要修正的indexPath, 添加行数
    NSMutableArray *indexPathArray = [NSMutableArray array];
    
    for (NSUInteger i=startPosition; i<endPosition; i++) {
        
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    
    //插入或者删除相关节点
    if (expand) {
        
        [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    } else {
        
        [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }
}

/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *  parentNode 父节点
 *  返回此爹下一个爹的节点位置
 */
-(NSUInteger)removeAllNodesAtParentNode : (BLCourseListModel *)parentNode
{
    NSUInteger startPosition = [_tempData indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i = startPosition+1; i<_tempData.count; i++)
    {
        BLCourseListModel *node = [_tempData objectAtIndex:i];
        endPosition++;
        
        if (node.depth <= parentNode.depth)
        {
            break;
        }
        if(endPosition == _tempData.count-1)
        {
            endPosition++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (endPosition>startPosition)
    {
        [_tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}

@end
