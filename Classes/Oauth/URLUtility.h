

#import <Foundation/Foundation.h>
#import "MinroadOauth.h"


@interface URLUtility : NSObject {
	NSString * responseBody;
}
@property(nonatomic,retain) NSString *responseBody;
+(void)requestWithToken:(OAToken *)token request:(NSString *)request;
+(NSString *)getResponseBody;
+(void)postWithToken:(OAToken *)token request:(NSString *)request postBody:(NSString *)postBody;

@end
