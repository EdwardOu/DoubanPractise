//
//  PageCellBackground.h
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import <UIKit/UIKit.h>

typedef enum
{
	PageCellGroupPositionUnknown = 0,
	PageCellGroupPositionTop,
	PageCellGroupPositionBottom,
	PageCellGroupPositionMiddle,
	PageCellGroupPositionTopAndBottom
} PageCellGroupPosition;

@interface PageCellBackground : UIView
{
	PageCellGroupPosition position;
	BOOL selected;
	BOOL groupBackground;
	UIColor *strokeColor;
}

@property (nonatomic, assign) PageCellGroupPosition position;
@property (nonatomic, retain) UIColor *strokeColor;

+ (PageCellGroupPosition)positionForIndexPath:(NSIndexPath *)anIndexPath inTableView:(UITableView *)aTableView;
- (id)initSelected:(BOOL)isSelected grouped:(BOOL)isGrouped;

@end





