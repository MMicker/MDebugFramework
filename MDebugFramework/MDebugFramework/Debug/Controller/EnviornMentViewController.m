//
//  EnviornMentViewController.m
//  MDebugFramework
//
//  Created by micker on 15/11/30.
//  Copyright © 2015年 micker.cn All rights reserved.
//

#import "EnviornMentViewController.h"
#import "MDebug.h"

@interface EnviornMentViewController()
@property (nonatomic, strong) NSArray *data;


@end

@implementation EnviornMentViewController {
    NSInteger _curentIndex;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self action:@selector(saveEnvironment:)];;
    [self configData];
}

- (void) configData {
    _curentIndex = [[MDebug sharedInstance] currentEnv];
    self.title = [[MDebug sharedInstance] currentEnvString];
    self.data = @[@"online环境",@"prod环境",@"stage环境"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) saveEnvironment:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_curentIndex] forKey:@"DEBUG_CURRENT_ENV_INDEX"];
    self.title = [[MDebug sharedInstance] currentEnvString];
    [self.tableView reloadData];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dequeueReusableCellWithIdentifier];
    }
    
    NSString *value = self.data[indexPath.row];
    cell.accessoryType = (_curentIndex == indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    cell.textLabel.text = value;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _curentIndex = indexPath.row;
    [tableView reloadData];
}

@end
