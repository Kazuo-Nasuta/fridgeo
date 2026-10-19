/*
     File: RecipeTableViewCell.m 
 Abstract: A table view cell that displays information about a Recipe.  It uses individual subviews of its content view to show the name, picture, description, and preparation time for each recipe.  If the table view switches to editing mode, the cell reformats itself to move the preparation time off-screen, and resizes the name and description fields accordingly.
  
  Version: 1.4 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2010 Apple Inc. All Rights Reserved. 
  
 */

#import "ContentTableViewCell.h"
#import "Item.h"

#pragma mark -
#pragma mark SubviewFrames category

@interface ContentTableViewCell (SubviewFrames)
- (CGRect)_imageViewFrame;
- (CGRect)_nameLabelFrame;
- (CGRect)_entryDateLabelFrame;
- (CGRect)_expireDateLabelFrame;
- (CGRect)_qtyLabelFrame;
@end


#pragma mark -
#pragma mark RecipeTableViewCell implementation

@implementation ContentTableViewCell

@synthesize content, imageView, nameLabel, entryDateLabel, expireDateLabel, qtyLabel;


#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];

        entryDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [entryDateLabel setFont:[UIFont systemFontOfSize:12.5]];
        [entryDateLabel setTextColor:[UIColor darkGrayColor]];
        [entryDateLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:entryDateLabel];
		
        expireDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [expireDateLabel setFont:[UIFont systemFontOfSize:12.5]];
        [expireDateLabel setTextColor:[UIColor darkGrayColor]];
        [expireDateLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:expireDateLabel];
		
        qtyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        qtyLabel.textAlignment = UITextAlignmentRight;
        [qtyLabel setFont:[UIFont systemFontOfSize:14.0]];
        [qtyLabel setTextColor:[UIColor blackColor]];
        [qtyLabel setHighlightedTextColor:[UIColor whiteColor]];
		qtyLabel.minimumFontSize = 7.0;
		qtyLabel.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:qtyLabel];

        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:nameLabel];
    }

    return self;
}


#pragma mark -
#pragma mark Laying out subviews

/*
 To save space, the prep time label disappears during editing.
 */
- (void)layoutSubviews {
    [super layoutSubviews];
	
    [imageView setFrame:[self _imageViewFrame]];
    [nameLabel setFrame:[self _nameLabelFrame]];
    [entryDateLabel setFrame:[self _entryDateLabelFrame]];
    [qtyLabel setFrame:[self _qtyLabelFrame]];
    [expireDateLabel setFrame:[self _expireDateLabelFrame]];
    if (self.editing) {
        qtyLabel.alpha = 0.0;
    } else {
        qtyLabel.alpha = 1.0;
    }
}

/*
#define IMAGE_SIZE          42.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    8.0
#define TEXT_RIGHT_MARGIN   5.0
#define PREP_TIME_WIDTH     120.0
#define EXPIRE_DATE_WIDTH     115.0
 */
#define IMAGE_SIZE          42.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    2.0
#define TEXT_RIGHT_MARGIN   2.0
#define PREP_TIME_WIDTH     50.0
#define EXPIRE_DATE_WIDTH     115.0

/*
 Return the frame of the various subviews -- these are dependent on the editing state of the cell.
 */
- (CGRect)_imageViewFrame {
    if (self.editing) {
        return CGRectMake(EDITING_INSET, 0.0, IMAGE_SIZE, IMAGE_SIZE);
    }
	else {
        return CGRectMake(3.0, 0.0, IMAGE_SIZE, IMAGE_SIZE);
    }
}

- (CGRect)_nameLabelFrame {
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + 3.0 + EDITING_INSET + TEXT_LEFT_MARGIN, 2.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 24.0);
    }
	else {
        return CGRectMake(IMAGE_SIZE + 3.0 + TEXT_LEFT_MARGIN, 2.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2 - PREP_TIME_WIDTH, 24.0);
    }
}

- (CGRect)_entryDateLabelFrame {
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + 3.0 + EDITING_INSET + TEXT_LEFT_MARGIN, 24.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 16.0);
    }
	else {
        return CGRectMake(IMAGE_SIZE + 3.0 + TEXT_LEFT_MARGIN, 24.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2 - EXPIRE_DATE_WIDTH, 16.0);
    }
}

- (CGRect)_qtyLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - PREP_TIME_WIDTH - TEXT_RIGHT_MARGIN, 4.0, PREP_TIME_WIDTH, 16.0);
}

- (CGRect)_expireDateLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
	return CGRectMake(contentViewBounds.size.width - EXPIRE_DATE_WIDTH - TEXT_RIGHT_MARGIN, 24.0, EXPIRE_DATE_WIDTH, 16.0);
}



#pragma mark -
#pragma mark Recipe set accessor

- (void)setContent:(Content *)newContent {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];

    if (newContent != content) {
        [content release];
        content = [newContent retain];
	}
	imageView.image = content.item.thumbnailImage;
	nameLabel.text = content.item.name;
	if (content.entryDate != nil) {
		entryDateLabel.text = [NSLocalizedString(@"entry:", @"CellLabel") stringByAppendingString:
							   [dateFormatter stringFromDate:content.entryDate]];
	}
	if (content.expireDate != nil) {
		expireDateLabel.text = [NSLocalizedString(@"expire:", @"CellLabel") stringByAppendingString:
								[dateFormatter stringFromDate:content.expireDate]];
	}
	qtyLabel.text = content.qty;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [content release];
    [imageView release];
    [nameLabel release];
    [entryDateLabel release];
    [expireDateLabel release];
	[qtyLabel release];
    [super dealloc];
}

@end
