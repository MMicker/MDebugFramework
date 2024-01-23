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
@property (nonatomic, strong) NSArray *allEnv;

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSBundle *manager = [NSBundle mainBundle];
        NSString *documentsDirectory = [manager pathForResource:@"Debug.bundle/env" ofType:@"plist"];
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:documentsDirectory];
        self.allEnv = [data valueForKey:@"env"];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidChangeStatusBarOrientationNotification
                                                  object:nil];
}


- (void)deviceOrientationDidChanged:(NSNotification *)notify{
//    [self setViewOrientation];
    CGRect btnFrame = _floatBallButton.frame;
    if (btnFrame.origin.x > 100) {
        _window = [UIApplication sharedApplication].delegate.window;
        _floatBallButton.frame = CGRectMake(_window.bounds.size.width - 44, 120, 44, 44);
    }
}


#pragma mark =======================

- (void)invocationEvent:(MDebugInvocationEvent)invocationEvent{
    if (MDebugInvocationEventBubble == invocationEvent) {
        _window = [UIApplication sharedApplication].delegate.window;
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
        _floatBallButton.layer.zPosition = 100000;
        _floatBallButton.frame = CGRectMake(0, 120, 44, 44);
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
    return MDebug_ENV_PROD;
}

- (NSString *) currentEnvString {
    NSInteger index = [self currentEnv];
    if (index < 0 || index >= self.allEnv.count) {
        return @"";
    }
    return [self.allEnv objectAtIndex:index];
}

#pragma mark =======================

- (UIViewController *) parentViewController {
    if (!_parentViewController) {
        _parentViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
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
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 44, 44)];
    button.backgroundColor = [UIColor clearColor];
    button.adjustsImageWhenHighlighted = YES;
    [button setImage:[UIImage imageNamed:@"Debug.bundle/images/bug"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(debugAction:) forControlEvents:UIControlEventTouchDownRepeat];
    return button;
}

@end
