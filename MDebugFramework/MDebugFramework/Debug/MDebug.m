//
//  Debug.m
//  MDebugFramework
//
//  Created by micker on 15/9/29.
//  Copyright © 2015年 micker.cn All rights reserved.
//

#import "MDebug.h"
#import "DebugRootViewController.h"
#import "FloatBallButton.h"

@interface MDebug () {
    UIWindow *_window;
}

@property (nonatomic, strong) FloatBallButton *floatBallButton;

@end

@implementation MDebug

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static MDebug *instance;
    dispatch_once(&onceToken, ^{
        instance = [[MDebug alloc] init];
        NSLog(@"当前环境是：%@", [instance currentEnvString]);
    });
    return instance;
}

#pragma mark =======================

- (void)invocationEvent:(MDebugInvocationEvent)invocationEvent{
    if (MDebugInvocationEventBubble == invocationEvent) {
        _window = [[UIApplication sharedApplication] keyWindow];
        [_window addSubview:self.floatBallButton];
    }
    if (MDebugInvocationEventNone == invocationEvent) {
        [_floatBallButton removeFromSuperview];
    }
}

- (FloatBallButton *) floatBallButton {
    if (!_floatBallButton) {
        _floatBallButton = [FloatBallButton buttonWithType:UIButtonTypeCustom];
        _floatBallButton.MoveEnable = YES;
        _floatBallButton.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 44, [[UIScreen mainScreen] bounds].size.width - 100, 44, 44);
        [_floatBallButton setImage:[UIImage imageNamed:@"Debug.bundle/images/bug"] forState:UIControlStateNormal];
        [_floatBallButton addTarget:self action:@selector(floatButtonAction:) forControlEvents:UIControlEventTouchDownRepeat];
    }
    return _floatBallButton;
}

- (void)floatButtonAction:(FloatBallButton *)button {
    if (!button.MoveEnabled) {
        [self debugAction:button];
    }
}

#pragma mark =======================

- (MDebug_ENV_TYPE) currentEnv {
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"DEBUG_CURRENT_ENV_INDEX"];
    if (number) {
        return [number integerValue];
    }
    return MDebug_ENV_ONLINE;
}

- (NSString *) currentEnvString {
    switch ([self currentEnv]) {
        case MDebug_ENV_ONLINE:
            return @"online环境";
            break;
        case MDebug_ENV_PROD:
            return @"prod环境";
            break;
        case MDebug_ENV_STAGE:
            return @"debug环境";
            break;
        default:
            break;
    }
    return @"";
}

#pragma mark =======================

- (UIViewController *) parentViewController {
    if (!_parentViewController) {
        _parentViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _parentViewController;
}

- (IBAction) debugAction:(id)sender {
    DebugRootViewController *controller = [[DebugRootViewController alloc] init];
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self.parentViewController pushViewController:controller animated:YES];
    } else {
        [self.parentViewController.navigationController pushViewController:controller animated:YES];
    }
}

- (UIView *) debugView {
    CGRect screenBound = [UIScreen mainScreen].bounds;
    CGRect shortcutFrame;
    shortcutFrame.size.width = 40.0f;
    shortcutFrame.size.height = 40.0f;
    shortcutFrame.origin.x = CGRectGetMaxX(screenBound)/2 - shortcutFrame.size.width/2;
    shortcutFrame.origin.y = CGRectGetMaxY(screenBound) - shortcutFrame.size.height - 84.0f;
    UIButton * button = [[UIButton alloc] initWithFrame:shortcutFrame];
    button.backgroundColor = [UIColor clearColor];
    button.adjustsImageWhenHighlighted = YES;
    [button setImage:[UIImage imageNamed:@"Debug.bundle/images/bug"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(debugAction:) forControlEvents:UIControlEventTouchDownRepeat];
    return button;
}

@end
