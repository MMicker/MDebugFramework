//
//  PictureViewController.m
//  MDebugFramework
//
//  Created by micker on 15/10/12.
//  Copyright © 2015年 micker.cn All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController()
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIImageView *) imageView {
    if (!_imageView) {
        CGRect rect = self.view.bounds;
        _imageView = [[UIImageView alloc] initWithFrame:rect];
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (void) setSourcePath:(NSString *) sourcePath {
    self.imageView.image = [UIImage imageWithContentsOfFile:sourcePath];
    [self.view addSubview:self.imageView];
    self.imageView.center = self.view.center;
}


@end
