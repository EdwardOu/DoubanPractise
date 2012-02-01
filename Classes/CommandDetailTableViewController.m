

#import "CommandDetailTableViewController.h"

#import "CompleteReviewTableViewController.h"

typedef enum { SectionHeader, SectionDetail,SectionFooter } Sections;
typedef enum { SectionHeaderTitle, SectionHeaderDate, SectionHeaderURL } HeaderRows;
typedef enum { SectionDetailSummary } DetailRows;

@implementation CommandDetailTableViewController

@synthesize item, dateString, summaryString,imageUrl;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
		
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
		// Super
    [super viewDidLoad];
	
		// Date
	if (item.date) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		[formatter setDateFormat:@"\rMM月dd号 aKK:mm"];
		self.dateString = [formatter stringFromDate:item.date ];
		
		[formatter release];
	}
	
		// Summary
	if (item.summary) {
		
		int startPoint=[item.summary rangeOfString:@"(http"].location;
		int endPoint=[item.summary rangeOfString:@"/)"].location;
		
		NSMutableString *origenal= [NSMutableString stringWithString:[item.summary stringByConvertingHTMLToPlainText]];
	    //subjectUrl=[origenal substringWithRange:NSMakeRange(startPoint, endPoint-startPoint+2)];
			//NSLog(@"!!!!!!!!!%@",subjectUrl);
		[origenal deleteCharactersInRange:NSMakeRange(startPoint, endPoint-startPoint+2)];
		self.summaryString = origenal ;
				
		
	} else {
		self.summaryString = @"[No Summary]";
	}
	
	
	if (item.content) {
		self.imageUrl=[item.content substringWithRange:NSMakeRange(10, 40)];
			//NSLog(@"%@",imageUrl);
	}
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
		// Return the number of sections.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
		// Return the number of rows in the section.
	switch (section) {
			
		default: return 1;
	}
}

	// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
		// Get cell
	static NSString *CellIdentifier = @"CellA";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
		// Display
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
	if (item) {
		
			// Item Info
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		
			// Display
		
		
		switch (indexPath.section) {
			case SectionHeader: {
				
				cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
				
				cell.textLabel.numberOfLines = 0;
				
				NSString *dateTile=@"\r评论时间:";
				dateString=[dateTile stringByAppendingString: dateString];
				[dateTile release];
				
				cell.textLabel.text= [itemTitle stringByAppendingString:dateString ];
				
					//image
				NSURL *url= [NSURL URLWithString:self.imageUrl];
				NSData *imageData=[[NSData alloc]initWithContentsOfURL:url];
				
				cell.imageView.image=[[UIImage alloc]initWithData:imageData];
				
				[imageData release];   
				break;
				
			}
				
			case SectionDetail: {
					// Summary
				cell.textLabel.text = summaryString;
				cell.textLabel.numberOfLines = 0; // Multiline
		        break;
			}
			case SectionFooter:{
				
				cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
				cell.textLabel.text = @"查看完整影评";		
				cell.textAlignment=1;
				cell.selectionStyle=UITableViewCellSelectionStyleBlue;
				cell.textLabel.numberOfLines = 1; // Multiline
				break;
			}
				
		}
	}
    
    return cell;
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == SectionHeader) {
		
			// Regular
		return 140;
		
	} else if (indexPath.section==SectionFooter) {
		
		return 30;
		
	}else{
		
			// Get height of summary
		NSString *summary = @"[No Summary]";
		if (summaryString) summary = summaryString;
		summarySize = [summary sizeWithFont:[UIFont systemFontOfSize:15] 
						  constrainedToSize:CGSizeMake(self.view.bounds.size.width - 40, MAXFLOAT)  // - 40 For cell padding
							  lineBreakMode:UILineBreakModeWordWrap];
		
		return summarySize.height + 16; // Add padding
		
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
		// FOR DETAILCOMMAND PUSH the Nav
	if (indexPath.section==SectionFooter) {
		if (item.link) {
			
			[NSThread detachNewThreadSelector:@selector(processData:)
									 toTarget:self
								   withObject:[NSNumber numberWithInt:6]];
			[self showLoadingIndicator];
			
			
			[self showProgressAlert:@"Loading" withMessage:@"please wait"];
			
			[self performSelector:@selector(loadController) withObject:nil afterDelay:1];
			
			[self performSelector:@selector(hideLoadingIndicator) withObject:nil afterDelay:3];
			
			
			
			
			
		}
		
		
		
	}

	
		// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}



- (void)showProgressAlert:(NSString*)title withMessage:(NSString*)message {
    UIAlertView* alertView = [[[UIAlertView alloc] initWithTitle:title
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:nil
                                               otherButtonTitles:nil]autorelease];
	
	progressView_ = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progressView_.frame = CGRectMake(30, 80, 225, 30);
	[alertView addSubview:progressView_];
	
    [alertView show];
    
  
}


- (void)processData:(NSNumber*)total {
	
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
	
    int totalData = [total intValue];
	
    for (int i = 0; i < totalData; ++i) {
		
			// Update UI to show progess.
		
        float progress = (float)i / totalData;
		
        NSNumber* progressNumber = [NSNumber numberWithFloat:progress];
		
        [self performSelectorOnMainThread:@selector(updateProgress:)
		 
                               withObject:progressNumber
		 
                            waitUntilDone:YES];
		
        
		
			// Process.
		
        [NSThread sleepForTimeInterval:0.1];
		
    }
	[self performSelectorOnMainThread:@selector(dismissProgressAlert)
	 
                           withObject:nil
	 
                        waitUntilDone:YES];
	
		// Other finalizations.
	
    
	
    [pool release];
    [NSThread exit];
}
	
- (void)updateProgress:(NSNumber*)progress {
	
    progressView_.progress = [progress floatValue];
}

- (void)dismissProgressAlert {
    if (progressView_ == nil) {
        return;
    }
	
    if ([progressView_.superview isKindOfClass:[UIAlertView class]]) {
        UIAlertView* alertView = (UIAlertView*)progressView_.superview;
        [alertView dismissWithClickedButtonIndex:0 animated:NO];
    }
	
    [progressView_ release];
    progressView_ = nil;
}


-(void)loadController{
	
	completeReview = [[CompleteReviewTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	completeReview.item = self.item;
	[self.navigationController pushViewController:completeReview animated:YES];
	
	
	
}


- (void)hideLoadingIndicator
{
	UIActivityIndicatorView *indicator =
	(UIActivityIndicatorView *)self.navigationItem.rightBarButtonItem;
	if ([indicator isKindOfClass:[UIActivityIndicatorView class]])
	{
		[indicator stopAnimating];
	}
	UIBarButtonItem *refreshButton =
	[[[UIBarButtonItem alloc]
	  initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
	  target:self
	  action:@selector(refresh:)]
	 autorelease];
	[self.navigationItem setRightBarButtonItem:refreshButton animated:YES];
}
- (void)showLoadingIndicator
{
	UIActivityIndicatorView *indicator =
	[[[UIActivityIndicatorView alloc]
	  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]
	 autorelease];
	indicator.frame = CGRectMake(0, 0, 24, 24);
	[indicator startAnimating];
	UIBarButtonItem *progress =
	[[[UIBarButtonItem alloc] initWithCustomView:indicator] autorelease];
	[self.navigationItem setRightBarButtonItem:progress animated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[completeReview release];
	[summaryString release];
	[item release];
    [super dealloc];
}


@end

