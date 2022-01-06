//
//  TextViewController.m
//  MDebugFramework
//
//  Created by micker on 15/10/12.
//  Copyright © 2015年 micker.cn All rights reserved.
//

#import "TextViewController.h"
#import "MDebugUtils.h"

@interface TextViewController()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UILabel *) label {
    if (!_label) {
        CGRect rect = self.view.bounds;
        _label = [[UILabel alloc] initWithFrame:rect];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.numberOfLines = 0;
    }
    return _label;
}

- (UIScrollView *) scrollView {
    if (!_scrollView) {
        CGRect rect = self.view.bounds;
        _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    }
    return _scrollView;
}

- (void) setSourcePath:(NSString *) sourcePath {
    CGRect rect = self.view.bounds;
    NSString *text = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    
    CGSize size =  [text boundingRectWithSize:CGSizeMake(rect.size.width, 200000)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;;
    self.label.text = text;
    _label.frame = CGRectMake(0, 0, size.width, size.height);
    
    if (size.height < rect.size.height) {
        size.height = rect.size.height + 1;
    }
    [self.scrollView addSubview:self.label];
    [self.scrollView setContentSize:size];
    [self.view addSubview:self.scrollView];
}

@end


@implementation UserDefaultsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = self.view.bounds;
    
    NSString *text = @"";
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    dictionary = [MDebugUtils makeJsonDictionary:dictionary];
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        text =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    CGSize size =  [text boundingRectWithSize:CGSizeMake(rect.size.width, 200000)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;;
    self.label.text = text;
    self.label.frame = CGRectMake(0, 0, size.width, size.height);
    
    if (size.height < rect.size.height) {
        size.height = rect.size.height + 1;
    }
    [self.scrollView addSubview:self.label];
    [self.scrollView setContentSize:size];
    [self.view addSubview:self.scrollView];
    
}

@end
