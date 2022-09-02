//
//  SandBoxViewController.m
//  MDebugFramework
//
//  Created by micker on 15/9/29.
//  Copyright © 2015年 micker.cn All rights reserved.
//

#import "SandBoxViewController.h"
#import "UIViewController+Path.h"
#import "MDebugTableViewCell.h"

static NSString *extentions [] = {
    @"plist",
    @"mp3",
    @"db",
    @"png",
    @"jpg"
};

static NSString *viewControllers [] = {
    @"PlistViewController",
    @"AudioViewController",
    @"DatabaseViewController",
    @"PictureViewController",
    @"PictureViewController",
};



@interface SandBoxViewController ()
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSFileManager  *fileManager;
@end

@implementation SandBoxViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MDebugTableViewCell class] forCellReuseIdentifier:@"SANDBOX_CELL"];
    if (!self.filePath) {
        self.filePath = NSHomeDirectory();
    }
    [self configData];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
}

- (void) configData {
    self.fileManager = [NSFileManager defaultManager];
    self.data = [NSMutableArray arrayWithArray: [self.fileManager contentsOfDirectoryAtPath:self.filePath error:nil]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDebugTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SANDBOX_CELL" forIndexPath:indexPath];
    cell.textLabel.text = self.data[indexPath.row];
    NSString *subPath = [self.filePath stringByAppendingPathComponent:self.data[indexPath.row]];
    BOOL directiory = NO;
    [_fileManager fileExistsAtPath:subPath isDirectory:&directiory];
    cell.accessoryType = directiory ? UITableViewCellAccessoryDisclosureIndicator :UITableViewCellAccessoryNone ;
    cell.imageView.image = [UIImage imageNamed:directiory ? @"Debug.bundle/images/folder" : @"Debug.bundle/images/file"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle ) {
        NSString *subPath = [self.filePath stringByAppendingPathComponent:self.data[indexPath.row]];
        NSError *error = nil;
        [_fileManager removeItemAtPath:subPath error:&error];
        if (!error) {
            [self.data removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            NSLog(@"delete failed at path:%@", subPath);
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *current = self.data[indexPath.row];
    NSString *subPath = [self.filePath stringByAppendingPathComponent:current];
    BOOL directiory = NO;
    [_fileManager fileExistsAtPath:subPath isDirectory:&directiory];
    
    if (directiory) {
        SandBoxViewController *controller = [[SandBoxViewController alloc] init];
        controller.title = current;
        controller.filePath = subPath;
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        NSString *pathExtension = [subPath pathExtension];
        Class clz  = NULL;
        for (int i = 0 ; i < 5; i++) {
            NSString *extention = extentions[i];
            if (NSOrderedSame == [extention caseInsensitiveCompare:pathExtension] ) {
                NSString *stringController = viewControllers[i];
                clz = NSClassFromString(stringController);
            }
        }
        if (!clz) {
            clz = NSClassFromString(@"TextViewController");
        }
        
        UIViewController * controller = [[clz alloc] init];
        controller.title = current;
        [controller setSourcePath:subPath];
        [self.navigationController pushViewController:controller animated:YES];
    }
}@end
