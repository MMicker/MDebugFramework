//
//  MDebugTableViewCell.m
//  MDebugFramework
//
//  Created by Micker on 2021/7/29.
//  Copyright © 2021 micker. All rights reserved.
//

#import "MDebugTableViewCell.h"

@implementation MDebugTableViewCell

- (void) configDefaultBackground {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
