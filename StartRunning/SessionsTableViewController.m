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

@interface SessionsTableViewController ()

@property(nonatomic,strong)PlistManager *plistManager;

@end

@implementation SessionsTableViewController{
Session *session;
}

-(PlistManager *)plistManager{
	if (_plistManager==nil) {
    _plistManager=[[PlistManager alloc]init];
	}
	return _plistManager;
}

- (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad{
	[super viewDidLoad];
  
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
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sessionCell" forIndexPath:indexPath];
	 Session *indexSession=[[Session alloc]init];
	 indexSession=[[self.plistManager arrayOfSessions]objectAtIndex:indexPath.row];

	 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	 [formatter setDateFormat:@"dd-MM-yyyy"];
	 NSDate *date=[indexSession valueForKey:@"sessionDate"];
	 NSString *stringFromDate = [formatter stringFromDate:date];
	 cell.textLabel.text=stringFromDate;

 return cell;
 }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

	session=[self.plistManager loadSessionWithIndex:indexPath.row+1];
	[self performSegueWithIdentifier:@"goToSummarySegue" sender:self];
	
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


 #pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

	if([segue.identifier isEqualToString:@"goToSummarySegue"]) {
		SummaryViewController* summary = segue.destinationViewController;

		summary.session=session;
	}

}


@end
