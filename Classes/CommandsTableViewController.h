

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface CommandsTableViewController : UITableViewController <MWFeedParserDelegate> {
	
	NSInteger rowIndex;
		// Parsing
	MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	
		// Displaying
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;
	
}
@property (nonatomic, retain) NSArray *itemsToDisplay;


- (id)initWithRowIndex:(NSInteger)rowIndex;

@end
