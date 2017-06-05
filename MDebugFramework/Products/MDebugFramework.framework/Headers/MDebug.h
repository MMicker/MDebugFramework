//
//  MDebug.h
//  MDebugFramework
//
//  Created by micker on 15/9/29.
//  Copyright © 2015年 micker.cn All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  接口环境类型，业务方据此作具体的逻辑判断
 */
typedef NS_ENUM(NSInteger , MDebug_ENV_TYPE) {
    MDebug_ENV_PROD = 0,                //online env
    MDebug_ENV_STAGE,                   //stage env
    MDebug_ENV_SIT,                     //sit env
};

/**
 *  呼出方式
 */
typedef NS_ENUM (NSInteger , MDebugInvocationEvent) {
    MDebugInvocationEventNone = 0,    // 静默模式
    MDebugInvocationEventBubble,      // 通过悬浮小球呼出
    
} ;


/*
 当前环境值发生变化时的通知
 */
FOUNDATION_EXPORT  NSString * const MDEBUG_ENVIRONMENT_STATUS_CHANGED_NOTIFICATION;

@interface MDebug : NSObject 

@property (nonatomic, weak) UIViewController *parentViewController;

+ (instancetype) sharedInstance;

/**
 *  设置Debug呼出样式
 *
 *  @return
 */
- (void)invocationEvent:(MDebugInvocationEvent)invocationEvent;

/**
 *  返回当前的环境类型，具体的逻辑判断，由业务方进行逻辑处理
 *
 *  @return 仅在debug模式下有用，在release环境下，返回为nil;
 */
- (MDebug_ENV_TYPE) currentEnv;

/**
 *  当前环境值
 *
 *  @return 当前环境的字符串，用于输出
 */
- (NSString *) currentEnvString;

/**
 *  DEBUG模式下，提供一个展示的入口视图
 *  每次调用均会创建，业务方需要自己持有
 *  @return 仅在debug模式下有用，在release环境下，返回为nil;
 */
- (UIView *) debugView;

@end



