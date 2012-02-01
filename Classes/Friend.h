	//
	//  Friend.h
	//  Douban
	//
	//  Created by ou on 12-1-5.
	//  Copyright 2012 __MyCompanyName__. All rights reserved.
	//

#import <Foundation/Foundation.h>


@interface Friend : NSObject {
	
@private
	NSString *_date;
@private
	NSString *_friendsName;
@private
	NSString *_broadCast;
@private
	NSString *_iconUrl;
@private
	NSString *_commentsCount;
@private
	NSString *_broadCastId;
	@private
	NSString *_recommandComment;
	@private
	NSArray *_topicArray;
	@private
	NSArray *_groupArray;
	
}
@property (nonatomic,retain)  NSString *_friendsName;
@property (nonatomic,retain)  NSString *_broadCast;
@property (nonatomic,retain)  NSString *_iconUrl;
@property (nonatomic,retain)  NSString *_date;
@property (nonatomic,retain)  NSString *_commentsCount;
@property (nonatomic,retain)  NSString *_broadCastId;
@property (nonatomic,retain)  NSString *_recommandComment;
@property (nonatomic,retain)  NSArray *_topicArray;
@property (nonatomic,retain)  NSArray *_groupArray;

-(id)initWithProperties:(NSString *)friendsName broadCast:(NSString *)broadCast iconUrl:(NSString *)iconUrl date:(NSString *)date commentsCount:(NSString *)commentsCount broadCastId:(NSString *)broadCastId recommandComment:(NSString *)recommandComment topicArray:(NSArray *)topicArray groupArray:(NSArray *)groupArray;

@end
