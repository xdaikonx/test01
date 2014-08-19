//
//  CustomTableViewCell.m
//  CycleAssist
//
//  Created by 荻原由佳 on 2014/08/19.
//  Copyright (c) 2014年 荻原大輔. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
