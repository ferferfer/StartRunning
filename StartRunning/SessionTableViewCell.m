//
//  SessionTableViewCell.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 21/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "SessionTableViewCell.h"

@implementation SessionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
	self.backgroundColor=[UIColor clearColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
