//
//  SecureLabel.h
//
//  Copyright © 2021 Jaesung Jung. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN API_AVAILABLE(ios(13.0)) NS_SWIFT_NAME(SecureLabel) NS_SWIFT_UI_ACTOR

/// A view that displays one or more lines of informational text with prevents capture.
@interface CPKSecureLabel : UIView <NSCoding, UIContentSizeCategoryAdjusting>

/// The text that the label displays.
@property (nullable, nonatomic, copy) NSString *text;

/// The font of the text.
@property (null_resettable, nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;

/// The color of the text.
@property (null_resettable, nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

/// The shadow color of the text.
@property (nullable, nonatomic, strong) UIColor *shadowColor UI_APPEARANCE_SELECTOR;

/// The shadow offset, in points, for the text.
@property (nonatomic) CGSize shadowOffset UI_APPEARANCE_SELECTOR;

/// The technique for aligning the text.
@property (nonatomic) NSTextAlignment textAlignment;

/// The technique for wrapping and truncating the label’s text.
@property (nonatomic) NSLineBreakMode lineBreakMode;

/// The strategy that the system uses to break lines when laying out multiple lines of text.
@property (nonatomic) NSLineBreakStrategy lineBreakStrategy;

/// The styled text that the label displays.
@property (nullable, nonatomic, copy) NSAttributedString *attributedText;

/// The highlight color for the label’s text.
@property (nullable, nonatomic, strong) UIColor *highlitedTextColor UI_APPEARANCE_SELECTOR;

/// A Boolean value that determines whether the label draws its text with a highlight.
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

/// A Boolean value that determines whether the system ignores and removes user events for this label from the event queue.
@property (nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;

/// A Boolean value that determines whether the label draws its text in an enabled state.
@property (nonatomic, getter=isEnabled) BOOL enabled;

/// The maximum number of lines for rendering text.
@property (nonatomic) NSInteger numberOfLines;

/// A Boolean value that determines whether the label reduces the text’s font size to fit the title string into the label’s bounding rectangle.
@property (nonatomic) BOOL adjustsFontSizeToFitWidth;

/// An option that controls whether the text's baseline remains fixed when text needs to shrink to fit in the label.
@property (nonatomic) UIBaselineAdjustment baselineAdjustment;

/// The minimum scale factor for the label’s text.
@property (nonatomic) CGFloat minimumScaleFactor;

/// The preferred maximum width, in points, for a multiline label.
@property (nonatomic) CGFloat preferredMaxLayoutWidth;

/// A Boolean value that determines whether the label tightens text before truncating.
@property(nonatomic) BOOL allowsDefaultTighteningForTruncation;

/// Returns the drawing rectangle for the label’s text.
/// @param bounds The bounding rectangle of the label.
/// @param numberOfLines The maximum number of lines to use for the label. The value 0 indicates the label has no maximum number of lines and the rectangle should encompass all of the text.
/// @return  The computed drawing rectangle for the label’s text.
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines;

/// Draws the label’s text, or its shadow, in the specified rectangle.
/// @param rect The rectangle in which to draw the text.
- (void)drawTextInRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
