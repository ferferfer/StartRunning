//
//  SessionsTableViewController.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 20/07/14.
//  Copyright (c) 2014 ironHack. All rights reserved.
//

#import "SessionsTableViewController.h"
#import "PlistManager.h"
#import "SummaryViewController.h"
#import "SessionTableViewCell.h"
#import "TimersManager.h"
#import "UIColor+CustomColor.h"

@interface SessionsTableViewController ()

@property(nonatomic,strong)PlistManager *plistManager;
@property(nonatomic,strong)Session *session;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SessionsTableViewController

-(PlistManager *)plistManager{
	if (_plistManager==nil) {
    _plistManager=[[PlistManager alloc]init];
	}
	return _plistManager;
}

-(Session *)session{
	if (_session==nil) {
    _session=[[Session alloc]init];
	}
	return _session;
}

-(void)viewWillAppear:(BOOL)animated{
	[self.tableView reloadData];
}

- (void)viewDidLoad{
	[super viewDidLoad];
  self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
	self.navigationController.navigationBar.backgroundColor=[UIColor appGreenColor];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return [self.plistManager numberofSessionsInPlist]-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	SessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sessionCell" forIndexPath:indexPath];
	Session *indexSession=[[Session alloc]init];
	indexSession=[[self.plistManager arrayOfSessions]objectAtIndex:indexPath.row];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd/MM/yyyy"];
	NSDate *date=[indexSession valueForKey:@"sessionDate"];
	NSString *stringFromDate = [formatter stringFromDate:date];
	
	NSNumber *intervalRun=[indexSession valueForKey:@"timeRunning"];
	NSNumber *intervalWalk=[indexSession valueForKey:@"timeWalking"];
	TimersManager *timerManager=[[TimersManager alloc]init];
	cell.timeRunnedLabel.text=[timerManager returnTimeFormatWithSeconds:[intervalRun intValue]];
	cell.timeWalkedLabel.text=[timerManager returnTimeFormatWithSeconds:[intervalWalk intValue]];
	cell.dateLabel.text=stringFromDate;
	
	return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if([segue.identifier isEqualToString:@"goToSummarySegue"]) {
		SummaryViewController* summary = [segue destinationViewController];
		NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
		self.session=[self.plistManager loadSessionWithIndex:indexPath.row+1];
		summary.session=self.session;
		summary.navigationBar=YES;
	}
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 68;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */




@end
