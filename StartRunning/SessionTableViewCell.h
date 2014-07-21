//
//  SessionTableViewCell.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 21/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeWalkedLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRunnedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
