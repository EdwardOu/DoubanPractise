//
//  LabelCell.m
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "LabelCell.h"

@implementation LabelCell
- (void)handleSelectionInTableView:(UITableView *)aTableView 
{
	[super handleSelectionInTableView:aTableView];
	
	
}
//
// configureForData:tableView:indexPath:
//
// Invoked when the cell is given data. All fields should be updated to reflect
// the data.
//
// Parameters:
//    dataObject - the dataObject (can be nil for data-less objects)
//    aTableView - the tableView (passed in since the cell may not be in the
//		hierarchy)
//    anIndexPath - the indexPath of the cell
//
- (void)configureForData:(id)dataObject
	tableView:(UITableView *)aTableView
	indexPath:(NSIndexPath *)anIndexPath
{
	[super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
	
	self.textLabel.text =dataObject;
	self.textLabel.textColor=[UIColor lightGrayColor];
		self.textLabel.lineBreakMode=UILineBreakModeWordWrap;
	self.textLabel.numberOfLines=0;
	
		
	
}

@end
