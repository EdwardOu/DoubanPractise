
#import "URLUtility.h"
#import "OAPlaintextSignatureProvider.h"

@implementation URLUtility
@synthesize responseBody;
+ (NSString*)urlEncode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding {
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects://@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" ,
							//@"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
	
    NSArray *replaceChars = [NSArray arrayWithObjects://@"%3B" , @"%2F" , @"%3F" , @"%3A" , 
                             @"%40" , @"%26" , 
							 //@"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
	
    int len = [escapeChars count];
	
    NSString *temp = [originalString stringByAddingPercentEscapesUsingEncoding:stringEncoding];
	
    int i;
    for(i = 0; i < len; i++)
    {
        temp = [temp stringByReplacingOccurrencesOfString:[escapeChars objectAtIndex:i]
                                               withString:[replaceChars objectAtIndex:i]
                                                  options:NSLiteralSearch
                                                    range:NSMakeRange(0, [temp length])];
    }
	
    NSString *out = [NSString stringWithString: temp];
	
    return out;
}

#pragma mark 获得时间戳
+(NSString *)_generateTimestamp 
{
    return [NSString stringWithFormat:@"%d", time(NULL)];
}

#pragma mark 获得随时字符串
+(NSString *)_generateNonce 
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    NSMakeCollectable(theUUID);
    return (NSString *)string;
}

#pragma mark api

+(void)requestWithToken:(OAToken *)token request:(NSString *)request
{
	
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:APPKEY secret:APPSECRET];
	
	OAHMAC_SHA1SignatureProvider *hmacSha1Provider = [[OAHMAC_SHA1SignatureProvider alloc] init];
	//OAPlaintextSignatureProvider *plaintextProvider = [[OAPlaintextSignatureProvider alloc] init];
	
	OAMutableURLRequest *hmacSha1Request = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[self urlEncode:request stringEncoding:NSUTF8StringEncoding]]
																			consumer:consumer
																			   token:token
																			   realm:NULL
																   signatureProvider:hmacSha1Provider
																			   nonce:[self _generateNonce]
																		   timestamp:[self _generateTimestamp]];
	
	//豆瓣方法在这里修改 PUT DELETE POST
	
	//[hmacSha1Request setHTTPMethod:@"POST"];
	
	OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:hmacSha1Request 
                         delegate:self
                didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
                  didFailSelector:@selector(requestTokenTicket:failedWithError:)];
}


+(void)postWithToken:(OAToken *)token request:(NSString *)request postBody:(NSString *)postData
{
	
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:APPKEY secret:APPSECRET];
	

		//OAPlaintextSignatureProvider *plaintextProvider = [[OAPlaintextSignatureProvider alloc] init];
	
	OAMutableURLRequest *hmacSha1Request = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[self urlEncode:request stringEncoding:NSUTF8StringEncoding]]
																		   consumer:consumer
																			  token:token
																			  realm:NULL
																  signatureProvider:[[OAPlaintextSignatureProvider alloc] init]
																			  nonce:[self _generateNonce]
																		  timestamp:[self _generateTimestamp]];

	
	[hmacSha1Request setHTTPMethod:@"POST"];
	
		
	OADataFetcher *fetcher = [[OADataFetcher alloc] init];
	
	fetcher.postData=postData;
	
    [fetcher fetchDataWithRequest:hmacSha1Request 
                         delegate:self
                didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
                  didFailSelector:@selector(requestTokenTicket:failedWithError:)];
}


+(void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data
{
		responseBody= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
}
+(void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error 
{
	NSLog(@"%@",error);
}

+(NSString *)getResponseBody{
	
	return responseBody;
}
-(void)dealloc{
	[responseBody release] ;
	
}


@end
