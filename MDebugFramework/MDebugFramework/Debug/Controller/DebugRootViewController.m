//
//  RootViewController.m
//  MDebugFramework
//
//  Created by micker on 15/9/29.
//  Copyright © 2015年 micker.cn All rights reserved.
//

#import "DebugRootViewController.h"

@interface DebugRootViewController ()
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation DebugRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Debug";
    self.data = [NSMutableArray array];
    [self configData];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
}


- (void) configData {
    NSBundle *manager = [NSBundle mainBundle];
    NSString *documentsDirectory = [manager pathForResource:@"Debug.bundle/debug" ofType:@"plist"];
    self.data = [[NSMutableArray alloc] initWithContentsOfFile:documentsDirectory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *dequeueReusableCellWithIdentifier = @"dequeueReusableCellWithIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusableCellWithIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dequeueReusableCellWithIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.data[indexPath.row][@"name"];
    cell.detailTextLabel.text = self.data[indexPath.row][@"author"];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *classString = self.data[indexPath.row][@"class"];
    Class newClass = NSClassFromString(classString);
    UIViewController *controller = [[newClass alloc] init];
    controller.title = self.data[indexPath.row][@"name"];
    if (controller)
        [self.navigationController pushViewController:controller animated:YES];
}

@end
