

#import "MinroadOauth.h"


@implementation MinroadOauth
@synthesize delegate;

#pragma mark 获得时间戳
- (NSString *)_generateTimestamp 
{
    return [NSString stringWithFormat:@"%d", time(NULL)];
}

#pragma mark 获得随时字符串
- (NSString *)_generateNonce 
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    NSMakeCollectable(theUUID);
    return (NSString *)string;
}

#pragma mark 开始认证
- (void)startOauth
{
	consumer = [[OAConsumer alloc] initWithKey:APPKEY secret:APPSECRET];
	
	hmacSha1Provider = [[OAHMAC_SHA1SignatureProvider alloc] init];
	hmacSha1Request = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:RequestURL]
                                                      consumer:consumer
                                                         token:NULL
                                                         realm:NULL
                                             signatureProvider:hmacSha1Provider
                                                         nonce:[self _generateNonce]
                                                     timestamp:[self _generateTimestamp]];
	
	OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:hmacSha1Request 
                         delegate:self
                didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
                  didFailSelector:@selector(requestTokenTicket:failedWithError:)];
}


- (void)startAccessOauth
{
	
	
	hmacSha1Request1 = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:AccessURL]
																			consumer:consumer
																			   token:token
																			   realm:NULL
																   signatureProvider:hmacSha1Provider
																			   nonce:[self _generateNonce]
																		   timestamp:[self _generateTimestamp]];
	
	//[hmacSha1Request1 setHTTPMethod:@"POST"];
	//[hmacSha1Request setOAuthParameterName:@"oauth_verifier" withValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"oauth_verifier"]];
	
	OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:hmacSha1Request1 
                         delegate:self
                didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
                  didFailSelector:@selector(requestTokenTicket:failedWithError:)];
}


#pragma mark delegate
- (void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data {
  
	if ([[ticket request] isEqual:hmacSha1Request]) {
		NSString *responseBody = [[NSString alloc] initWithData:data
													   encoding:NSUTF8StringEncoding];
		NSLog(@"获得未授权的KEY:%@",responseBody);
		
		token = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
		
		NSString *tt = [token.key URLEncodedString];
		NSString *url = [NSString stringWithFormat:@"%@?oauth_token=%@&oauth_callback=%@&p=1",AuthorizeURL,tt,CallBackURL];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
		
	}
	else if ([[ticket request] isEqual:hmacSha1Request1])
	 {
		 NSString *responseBody = [[NSString alloc] initWithData:data
														encoding:NSUTF8StringEncoding];
		 NSLog(@"responseBody:%@",responseBody);
		 token = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
		 
		 [delegate OauthDidFinish:token];
	 }
   
    
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error {
	NSLog(@"%@",error);
}

@end
