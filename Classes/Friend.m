//
//  Friend.m
//  DoubanbroadCastId
//
//  Created by ou on 12-1-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Friend.h"


@implementation Friend

@synthesize _broadCast,_friendsName,_iconUrl,_date,_commentsCount,_broadCastId,_recommandComment,_topicArray,_groupArray;

-(id)initWithProperties:(NSString *)friendsName broadCast:(NSString *)broadCast iconUrl:(NSString *)iconUrl date:(NSString *)date commentsCount:(NSString *)commentsCount broadCastId:(NSString *)broadCastId recommandComment:(NSString *)recommandComment topicArray:(NSArray *)topicArray groupArray:(NSArray *)groupArray{
	
	if (self=[super self]) {
		self._iconUrl=iconUrl;
		self._broadCast=broadCast;
		self._friendsName=friendsName;
		self._date=date;
		self._commentsCount=commentsCount;
		self._broadCastId=broadCastId;
		self._recommandComment=recommandComment;
		self._topicArray=topicArray;
		self._groupArray=groupArray;
	}
	
	return self;
}
@end
