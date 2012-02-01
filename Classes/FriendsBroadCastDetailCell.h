//
//  NibLoadedCell.h
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "PageCell.h"
#import "Friend.h"
@interface FriendsBroadCastDetailCell : PageCell
{  
	@private
	Friend *_friend;
	
	@private
	IBOutlet UILabel *label;	
}



@property (nonatomic, assign) Friend *_friend;


@end
