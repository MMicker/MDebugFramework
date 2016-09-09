//
//  PlistViewController.m
//  MDebugFramework
//
//  Created by micker on 15/10/12.
//  Copyright © 2015年 micker.cn All rights reserved.
//

#import "PlistViewController.h"

@interface PlistViewController ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation PlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UILabel *) label {
    if (!_label) {
        CGRect rect = self.view.bounds;
        _label = [[UILabel alloc]initWithFrame:rect];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.numberOfLines = 0;
    }
    return _label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIScrollView *) scrollView {
    if (!_scrollView) {
        CGRect rect = self.view.bounds;
        _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    }
    return _scrollView;
}

- (void) setSourcePath:(NSString *) sourcePath {
//    [self.view addSubview:self.label];
    NSString *text = @"";
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:sourcePath];
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        text =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    CGRect rect = self.view.bounds;
    CGSize size =  [text boundingRectWithSize:CGSizeMake(rect.size.width, 200000)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;;
    self.label.frame = CGRectMake(0, 0, size.width, size.height);
    self.label.text = text;

    if (size.height < rect.size.height) {
        size.height = rect.size.height + 1;
    }
    [self.scrollView addSubview:self.label];
    [self.scrollView setContentSize:size];
    [self.view addSubview:self.scrollView];

}

@end