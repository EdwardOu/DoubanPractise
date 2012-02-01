//
//  TextFieldCell.h
//  TableDesignRevisited
//
//  Created by Paul Wong on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "PageCell.h"

@interface TextFieldCell : PageCell
{
	UITextField *textField;
	UILabel *label;
}

@property (nonatomic, retain) UITextField *textField;

@end
