//
//  NibLoadedCell.m
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "NibLoadedCell2.h"
#import "PageViewController.h"
#import "CommandsTableViewController.h"
#import <QuartzCore/QuartzCore.h>

static NSString *_broadCast;
@implementation NibLoadedCell2

@synthesize label,image,broadcast;


//
// nibName
//
// returns the name of the nib file from which the cell is loaded.
//
+ (NSString *)nibName
{
	return @"ReviewNibCell";
}

//
// handleSelectionInTableView:
//
// Performs the appropriate action when the cell is selected
//
- (void)handleSelectionInTableView:(UITableView *)aTableView
{
	[super handleSelectionInTableView:aTableView];
	
	NSInteger rowIndex = [aTableView indexPathForCell:self].row;
	[((PageViewController *)aTableView.delegate).navigationController
		pushViewController:[[[CommandsTableViewController alloc] initWithRowIndex:rowIndex] autorelease]
		animated:YES];
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
//    anIndexPath - the indexPath of the 'cell
//
- (void)configureForData:(id)dataObject
			   tableView:(UITableView *)aTableView
			   indexPath:(NSIndexPath *)anIndexPath
{
	[super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
    
	self.broadcast.text=_broadCast;
	
	self.label.lineBreakMode=UILineBreakModeWordWrap;
	label.numberOfLines=0;
	
	label.text = dataObject;
		//设置layer
    CALayer *layer=[image layer];
		//是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
		//设置边框圆角的弧度
    [layer setCornerRadius:8.0];
		//设置边框线的宽
		//
    [layer setBorderWidth:1.2];
		//设置边框线的颜色
    [layer setBorderColor:[[UIColor  grayColor] CGColor]];
	
	
	
		
	if ([dataObject isEqual:@"Thiss is row"]) {
	
		image.image=[UIImage imageNamed:@"imagelogo.png"];
		
	}  
	if ([dataObject isEqual:@"Thsssis is row"]) {
		NSLog(@"Thsssis picture place remember....dude..");
		image.image=[UIImage imageNamed:@"home.png"];
	}
}


@end
