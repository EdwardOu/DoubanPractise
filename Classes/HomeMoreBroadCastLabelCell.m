//
//  LabelCell.m
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "HomeMoreBroadCastLabelCell.h"

@implementation HomeMoreBroadCastLabelCell
- (void)handleSelectionInTableView:(UITableView *)aTableView 
{
	[super handleSelectionInTableView:aTableView];
	
	home._friendsBroadCastPage++;

	[home fetchFriendsInfo];
	
	
	
	
	
	
	
	[home removeRowAtIndex:[indexPath row] inSection:home._friendsBroadCastPage-1 withAnimation:UITableViewRowAnimationTop];
	
	[home showWaiting];
	[self performSelector:@selector(moveTheRow) withObject:nil afterDelay:2.5];
	
     
	
	
	
}

- (void)configureForData:(id)dataObject
	tableView:(UITableView *)aTableView
	indexPath:(NSIndexPath *)anIndexPath
{
	[super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
	
	
	self.textLabel.text =@"更多广播";
	self.textLabel.textColor=[UIColor lightGrayColor];
	self.textLabel.textAlignment=1;
	
	home=dataObject;
	indexPath=anIndexPath;
	

}
-(void)moveTheRow{

	
[home.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[home _friendsBroadCastPage]] atScrollPosition:UITableViewScrollPositionTop animated:YES];
	
	[home makeRowslater];
	[home hideWaiting];
}



@end
