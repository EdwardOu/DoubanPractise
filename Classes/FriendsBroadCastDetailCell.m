//
//  NibLoadedCell.m
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "NibLoadedCell.h"
#import "PageViewController.h"
#import "FriendsBroadCastDetailCell.h"
#import <QuartzCore/QuartzCore.h>



@implementation FriendsBroadCastDetailCell

@synthesize _friend;

//
// nibName
//
// returns the name of the nib file from which the cell is loaded.
//
+ (NSString *)nibName
{
		
	return @"FriendsBroadCastDetailCell";
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
    
	_friend=dataObject;
	NSLog(@"[_friend _recommandComment]:%@",[_friend _recommandComment]);
	if ([[_friend _broadCast] hasPrefix:@"推荐"]) {
		
		
		NSString *RecommandBroadCast=[[NSString alloc]initWithFormat:@"%@",[_friend _recommandComment]];
		
		label.text=RecommandBroadCast;
		
		
	}else {
		
		label.text=[_friend _broadCast];
	}

	
	label.lineBreakMode=UILineBreakModeWordWrap;
	label.numberOfLines=0;
	
	
	//NSLog(@"[_friend _iconUrl]:%@",[_friend _iconUrl]);
//	NSMutableString *imageUrl=[[NSMutableString alloc]initWithString:[_friend _iconUrl]] ;
//	
//	int start=[imageUrl rangeOfString:@"/u"].location;
//	[imageUrl insertString:@"l" atIndex:start+2];
//	 NSLog(@"imageUrl:%@",imageUrl);
//	
//	NSURL *tempUrl=[NSURL URLWithString:imageUrl];
//	NSData *tempData=[[NSData alloc] initWithContentsOfURL:tempUrl];
//	
//	image.image=[[UIImage alloc] initWithData:tempData];
//	
//	
//		//设置layer
//    CALayer *layer=[image layer];
//		//是否设置边框以及是否可见
//    [layer setMasksToBounds:YES];
//		//设置边框圆角的弧度
//    [layer setCornerRadius:8.0];
//		//设置边框线的宽
//		//
//    [layer setBorderWidth:0.7];
//		//设置边框线的颜色
//    [layer setBorderColor:[[UIColor  grayColor] CGColor]];
			
	
}

-(void)dealloc{
	
	[super dealloc];
	
	
	
	
	
}

@end
