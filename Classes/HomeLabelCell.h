//
//  NibLoadedCell.h
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "PageCell.h"
#import "TBXML.h"
#import "Friend.h"
@interface HomeLabelCell : PageCell<UIAlertViewDelegate>
{  
	
	IBOutlet UILabel *broadCast;
	IBOutlet UIImageView *image;
    IBOutlet UILabel *name;
	 IBOutlet UILabel *date;
	IBOutlet UIButton *button;
	NSString *broadCastId;
	NSString *commentUser;
	NSMutableArray *commentsArray;
		NSMutableArray *commentUsersArray;
	int commentsCount;
	int commentFlag;
	NSMutableString *commentString;
	NSString *checkBroadCastId;
	UIAlertView *commentsReply;
	UITextField *replyTextField;
	Friend *friend;
	UITableView *tableView;
	NSIndexPath *indexPath;
	int showDetailFlag;
}
@property (nonatomic, retain) UILabel *date;
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *broadCast;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) NSString *broadCastId;
@property (nonatomic, retain) NSString *commentUser;
@property (nonatomic, retain) NSMutableString *commentString;
@property (nonatomic, retain) NSString *checkBroadCastId;
@property (nonatomic, retain) Friend *friend;


-(IBAction)showFreindsInfo;
-(IBAction)showFreindsImage;
-(IBAction)showComments;
-(IBAction)showDetail;

- (void) traverseElement:(TBXMLElement *)element;
@end
