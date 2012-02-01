//
//  LabelCell.h
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "PageCell.h"
#import "HomeViewController.h"

@interface HomeMoreBroadCastLabelCell : PageCell
{

	HomeViewController *home;
	NSIndexPath *indexPath;
}

-(void)moveTheRow:(UITableView *)TableView;

@end
