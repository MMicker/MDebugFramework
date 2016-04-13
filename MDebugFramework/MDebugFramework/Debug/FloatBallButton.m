//
//  FloatBallButton.m
//  FloatingBallTest
//
//  Created by m on 16/1/22.
//  Copyright © 2016年 shuzhongxian. All rights reserved.
//

#import "FloatBallButton.h"

@implementation FloatBallButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//触摸-清扫
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _MoveEnabled = NO;
    [super touchesBegan:touches withEvent:event];
    if (!_MoveEnable) {
        return;
    }
    // 开始时的位置
    UITouch *touch = [touches anyObject];
    _beginpoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _MoveEnabled = YES;//单击事件可用
    
    if (!_MoveEnable) {
        return;
    }
    // 当前的位置坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    //偏移量
    float offsetX = currentPosition.x - _beginpoint.x;
    float offsetY = currentPosition.y - _beginpoint.y;
    //移动后的中心坐标
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
    
    //x轴左右极限坐标
    if (self.center.x > (self.superview.frame.size.width-self.frame.size.width/2)) {
        CGFloat x = self.superview.frame.size.width-self.frame.size.width/2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    }else if (self.center.x < self.frame.size.width/2){
        CGFloat x = self.frame.size.width/2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    }
    
    //y轴上下极限坐标
    if (self.center.y > (self.superview.frame.size.height-self.frame.size.height/2)) {
        CGFloat x = self.center.x;
        CGFloat y = self.superview.frame.size.height-self.frame.size.height/2;
        self.center = CGPointMake(x, y);
    }else if (self.center.y <= self.frame.size.height/2){
        CGFloat x = self.center.x;
        CGFloat y = self.frame.size.height/2;
        self.center = CGPointMake(x, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_MoveEnable) {
        return;
    }
    if (self.center.x >= self.superview.frame.size.width/2) {//向右侧移动
        //偏移动画
        CGSize size = [[UIScreen mainScreen] bounds].size;
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        self.frame=CGRectMake(size.width - 40,self.center.y-20, 40.f,40.f);
        //提交UIView动画
        [UIView commitAnimations];
    }else{//向左侧移动
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        self.frame=CGRectMake(0.f,self.center.y-20, 40.f,40.f);
        //提交UIView动画
        [UIView commitAnimations];
    }
    //不加此句话，UIButton将一直处于按下状态
    [super touchesEnded: touches withEvent: event];
}

@end
