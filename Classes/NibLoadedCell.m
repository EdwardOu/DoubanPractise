//
//  NibLoadedCell.m
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "NibLoadedCell.h"
#import "PageViewController.h"
#import "CommandsTableViewController.h"
#import <QuartzCore/QuartzCore.h>

static NSString *_imageUrl;
static NSString *_broadCast;


@implementation NibLoadedCell

@synthesize label,image,broadcast,button;

//
// nibName
//
// returns the name of the nib file from which the cell is loaded.
//
+ (NSString *)nibName
{
		
	return @"HomeViewNibCell";
}

+(void)setImageUrl:(NSString *)imageUrl{
	
	_imageUrl=imageUrl;
}
+(void)setBroadCast:(NSString *)BroadCast{
	
	_broadCast=BroadCast;
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
 
	 
	if ([[label text] isEqual:@"Thiss is row"]) {
		[((PageViewController *)aTableView.delegate).navigationController
		 pushViewController:[[[CommandsTableViewController alloc ] initWithRowIndex:rowIndex] autorelease]
		 animated:YES];
	
	}
	if ([[label text] isEqual:@"Thsssis is row"]) {
		[((PageViewController *)aTableView.delegate).navigationController
		 pushViewController:[[[CommandsTableViewController alloc ] initWithRowIndex:rowIndex] autorelease]
		 animated:YES];
		
	}
	
	
	
	
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
	//
//    if (button ==nil) {
//		NSLog(@"reload!!");
//		button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//		button.frame=CGRectMake(220, 110, 45, 20);
//		button.alpha=0;
//		[UIView beginAnimations:nil context:NULL];
//		[UIView setAnimationDuration:1];
//		button.frame=CGRectMake(260, 110, 45, 20);
//		button.alpha=1.0;
//		[UIView commitAnimations];
//		
//			//commentButton.hidden=YES;
//		[aTableView addSubview:button];
//	}
//	
//
	


	
	
	
	
	
	self.label.lineBreakMode=UILineBreakModeWordWrap;
	label.numberOfLines=0;
	
	broadcast.lineBreakMode=UILineBreakModeWordWrap;
	broadcast.numberOfLines=0;
	
	broadcast.text=_broadCast;
	label.text = dataObject;
		//设置layer
    CALayer *layer=[image layer];
		//是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
		//设置边框圆角的弧度
    [layer setCornerRadius:8.0];
		//设置边框线的宽
		//
    [layer setBorderWidth:0.7];
		//设置边框线的颜色
    [layer setBorderColor:[[UIColor  grayColor] CGColor]];
		
		NSURL *tempUrl=[NSURL URLWithString:_imageUrl];
		NSData *tempData=[[NSData alloc] initWithContentsOfURL:tempUrl];
		
		image.image=[[UIImage alloc] initWithData:tempData];
		
	
}


@end
