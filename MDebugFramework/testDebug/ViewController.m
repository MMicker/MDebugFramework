//
//  ViewController.m
//  testDebug
//
//  Created by Micker on 16/4/13.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "ViewController.h"
#import "MDebug.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/tmp/114.png", NSHomeDirectory()]];
    [self.view addSubview:imageView];
    [MDebug sharedInstance].parentViewController = self;
    [self.view addSubview:[[MDebug sharedInstance] debugView]];
    
    [[MDebug sharedInstance] invocationEvent:MDebugInvocationEventBubble];
    
    NSLog(@"NSHomeDirectory() = %@", NSHomeDirectory());
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
