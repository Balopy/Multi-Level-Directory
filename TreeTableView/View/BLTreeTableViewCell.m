//
//  BLTreeTableViewself.m
//  BLTreeTableView
//
//  Created by yzla50010 on 16/8/31.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import "BLTreeTableViewCell.h"
#import "BLCourseListModel.h"

@interface BLBLTreeTableViewCell ()
@property (nonatomic, assign) CGFloat depath;
@end


@implementation BLBLTreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setNode:(BLCourseListModel *)node
{
    _node = node;
   
   
    CGFloat x = 10 + 20 * node.depth;
    self.depath = x;  
    
    switch (node.depth)
    {
        case courseType:{
            self.textLabel.text = node.courseName;
            self.imageView.image = [UIImage imageNamed:@"red_classBtn"];

        }  break;
        case chapterType:{
           
            self.textLabel.text = node.chapterName;
            self.imageView.image = [UIImage imageNamed:@"green_classBtn"];
        }
            break;
        case parterType: {
            
            self.textLabel.text = node.partName;
            self.imageView.image = [UIImage imageNamed:@"red_classBtn"];
        }
            break;
        case fourthType:{
            
            self.textLabel.text = @"我是你家老四";
            self.imageView.image = [UIImage imageNamed:@"矩形-31"];
        }
            break;
        case fiveType: {
            
            self.textLabel.text = @"这是最后一级了";
            self.imageView.image = [UIImage imageNamed:@"矩形-31-拷贝-2"];
        }
        default:
            break;
    }
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = self.depath;
    frame.size.width = [UIScreen mainScreen].bounds.size.width-self.depath-10;
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
