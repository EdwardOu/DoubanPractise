
#import <UIKit/UIKit.h>
#import "MWFeedItem.h"
#import "CompleteReviewTableViewController.h"

@interface CommandDetailTableViewController : UITableViewController {
    //*subjectUrl is spared,not used by now,but standby for extension; 
	//NSString *subjectUrl;
	MWFeedItem *item;
	NSString *dateString, *summaryString,*imageUrl;
	CGSize summarySize;
	CompleteReviewTableViewController *completeReview;
	UIProgressView *progressView_;
}

@property (nonatomic, retain) MWFeedItem *item;
@property (nonatomic, retain) NSString *dateString, *summaryString,*imageUrl;


- (void)hideLoadingIndicator;
- (void)showLoadingIndicator;
- (void)showProgressAlert:(NSString*)title withMessage:(NSString*)message;
@end
