//
//  FriendBroadCastDetailViewController.m
//  Douban
//
//  Created by ou on 12-1-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendBroadCastDetailViewController.h"
#import "GradientBackgroundTable.h"
#import "FriendsBroadCastDetailCell.h"
#import "LabelCell.h"
@implementation FriendBroadCastDetailViewController

@synthesize _friend,_detailMode;

-(id)initWithFriend:(Friend *)friend{
	
	if (self=[super init]) {
		self._friend=friend;
		self.hidesBottomBarWhenPushed = YES;
		
	}
	return self;
	
}

-(void)refresh{
	
	[self performSelector:@selector(createRows) withObject:nil afterDelay:0.5];
	[self showLoadingIndicator];
	
	[self hideLoadingIndicator];
}
-(void)createRows{
	NSLog(@"_groupArray:%@",[[self._friend _groupArray] objectAtIndex:0]);
	[self setConstantRowHeight:YES];
	
	if (_friend) {
		[self addSectionAtIndex:0 withAnimation:UITableViewRowAnimationLeft];
		
		[self
		 appendRowToSection:0
		 cellClass:[LabelCell class]
		 cellData:[_friend _broadCast]
		 
		 withAnimation:
		 UITableViewRowAnimationLeft];
		
	}
		
	
		
		if ([_friend _groupArray]) {
			[self addSectionAtIndex:1 withAnimation:UITableViewRowAnimationLeft];


	//	[self
//		 appendRowToSection:1
//		 cellClass:[HomeLabelCell class]
//		 cellData:friend
//		 
//		 withAnimation:
//		 UITableViewRowAnimationLeft];
	}
	
	
	
}
- (NSString *)tableView:(UITableView *)aTableView
titleForHeaderInSection:(NSInteger)section

{
	
		NSLog(@"_topicArray:%@",[[self._friend _topicArray] objectAtIndex:0]);
	
	if (section == 0)
	{
		return NSLocalizedString(@"广播详细", nil);
	}
	if (section ==1)
	{
		
		if ([[[self._friend _groupArray] objectAtIndex:0] hasPrefix:@"http://www.douban.com/group/"]) {
			_detailMode=[[NSString alloc]initWithString:@"group"];
			NSString *desc=[[NSString alloc] initWithFormat:@"小组:%@——%@",[[self._friend _groupArray] objectAtIndex:1],[[self._friend _topicArray] objectAtIndex:1]];
			return NSLocalizedString(desc, nil);
            [desc release];
			
			
		}else if ([[[self._friend _groupArray] objectAtIndex:0] hasPrefix:@"http://www.douban.com/people/"]) {
			
			
			
			if ([[[self._friend _topicArray] objectAtIndex:0] hasPrefix:@"http://www.douban.com/photos/"]){
				_detailMode=[[NSString alloc]initWithString:@"photo"];
				NSString *desc=[[NSString alloc] initWithFormat:@"%@的相册--%@",[[self._friend _groupArray] objectAtIndex:1],[[self._friend _topicArray] objectAtIndex:1]];
				return NSLocalizedString(desc, nil);
				[desc release];
			}

			if ([[[self._friend _topicArray] objectAtIndex:0] hasPrefix:@"http://www.douban.com/note/"]){
				_detailMode=[[NSString alloc]initWithString:@"note"];

				NSString *desc=[[NSString alloc] initWithFormat:@"%@的日记--%@",[[self._friend _groupArray] objectAtIndex:1],[[self._friend _topicArray] objectAtIndex:1]];
				return NSLocalizedString(desc, nil);
				[desc release];
			}
			
		}else if ([[[self._friend _groupArray] objectAtIndex:0] hasPrefix:@"http://www.douban.com/online/"]) {
			_detailMode=[[NSString alloc]initWithString:@"online"];
			NSString *desc=[[NSString alloc] initWithFormat:@"活动:%@",[[self._friend _groupArray] objectAtIndex:1]];
			return NSLocalizedString(desc, nil);
			 [desc release];
			
		}

		
	}
	
	
	return nil;
}	

-(void)viewDidLoad{
	
	[super viewDidLoad];
	[self refresh];
	[self showLoadingIndicator];
	
}

- (void)loadView
{
	GradientBackgroundTable *aTableView =
	[[[GradientBackgroundTable alloc]
	  initWithFrame:CGRectZero
	  style:UITableViewStyleGrouped]
	 autorelease];
	
	self.view = aTableView;
	self.tableView = aTableView;
}

-(void)dealloc{
	[super dealloc];
	[_friend release];
	[_detailMode release];
}







@end
