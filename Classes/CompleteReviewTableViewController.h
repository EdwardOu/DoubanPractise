//
//  CompleteReviewTableViewController.h
//  Douban
//
//  Created by ou on 11-12-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"

@interface CompleteReviewTableViewController : UITableViewController {
   
	MWFeedItem *item;
	NSString *reviewLink;	
	BOOL contentFinishFlag;
	NSMutableString *completeReview;
	NSString *title;
	CGSize summarySize;
	
}
@property (nonatomic,assign) NSString *reviewLink;
@property (nonatomic, retain) MWFeedItem *item;
@property (nonatomic, retain) NSMutableString *completeReview;

@end
