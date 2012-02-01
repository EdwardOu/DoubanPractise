//
//  PageCell.h
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import <UIKit/UIKit.h>

@class PageViewController;

@interface PageCell : UITableViewCell
{
	IBOutlet UIView *content;
	NSArray *contentArray;
	
}

@property (nonatomic, assign) UIView *content;

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;
+ (UITableViewCellStyle)style;
+ (CGFloat)rowHeight;
+(void)setRowHeightByContent:(CGFloat)rowHeight row:(int)row;

- (void)configureForData:(id)dataObject
	tableView:(UITableView *)aTableView
	indexPath:(NSIndexPath *)anIndexPath;
- (void)finishConstruction;
- (void)handleSelectionInTableView:(UITableView *)aTableView;

@end
