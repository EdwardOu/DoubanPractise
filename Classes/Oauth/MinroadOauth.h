

#import <Foundation/Foundation.h>
#import "OADataFetcher.h"

#import "KEY.h"

@protocol OauthToken

- (void)OauthDidFinish:(OAToken *)token;

@end


@interface MinroadOauth : NSObject {
	OAConsumer *consumer;
	OAMutableURLRequest *hmacSha1Request;//请求授权
	OAMutableURLRequest *hmacSha1Request1;//请求access
	OAToken *token;
	OAHMAC_SHA1SignatureProvider *hmacSha1Provider;
	
	id<OauthToken> delegate;
}
@property (assign,nonatomic) id<OauthToken> delegate;
- (void)startOauth;
- (void)startAccessOauth;
@end
