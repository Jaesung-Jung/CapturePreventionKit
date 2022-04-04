//
//  CPKSecureLabel.m
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

#import <AVFoundation/AVFoundation.h>

#import "CPKSecureLabel.h"
#import "CPKLabel.h"
#import "CVPixelBufferSupport.h"
#import "CMSampleBufferSupport.h"
#import "CPKQueue.h"

@interface CPKSecureLabel () <CPKLabelDelegate>

@property (nonnull, strong, nonatomic) CPKLabel *label;
@property (nonnull, strong, nonatomic) AVSampleBufferDisplayLayer *displayLayer;

@end

@implementation CPKSecureLabel

#pragma mark - Initializer

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self __setup];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  if (self = [super initWithCoder:coder]) {
    [self __setup];
  }
  return self;
}

#pragma mark - Override

- (CGSize)intrinsicContentSize {
  return self.label.intrinsicContentSize;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect textRect = [self.label textRectForBounds:self.bounds limitedToNumberOfLines:self.label.numberOfLines];
  CGFloat x = CGRectGetMinX(textRect);
  CGFloat y = CGRectGetMinY(textRect);
  CGFloat width = CGRectGetWidth(textRect);
  CGFloat height = CGRectGetHeight(textRect);
  CGRect frame = CGRectMake(x, y, width, height);

  [self.label setFrame:frame];
  [self.displayLayer setFrame:frame];
}

#pragma mark - Property

- (NSString *)text {
  return self.label.text;
}

- (void)setText:(NSString *)text {
  [self.label setText:text];
}

- (UIFont *)font {
  return self.label.font;
}

- (void)setFont:(UIFont *)font {
  [self.label setFont:font];
}

- (UIColor *)textColor {
  return self.label.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
  [self.label setTextColor:textColor];
}

- (UIColor *)shadowColor {
  return self.label.shadowColor;
}

- (void)setShadowColor:(UIColor *)shadowColor {
  [self.label setShadowColor:shadowColor];
}

- (CGSize)shadowOffset {
  return self.label.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
  [self.label setShadowOffset:shadowOffset];
}

- (NSTextAlignment)textAlignment {
  return self.textAlignment;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
  [self.label setTextAlignment:textAlignment];
}

- (NSLineBreakMode)lineBreakMode {
  return self.label.lineBreakMode;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
  [self.label setLineBreakMode:lineBreakMode];
}

- (NSLineBreakStrategy)lineBreakStrategy {
  return self.label.lineBreakStrategy;
}

- (void)setLineBreakStrategy:(NSLineBreakStrategy)lineBreakStrategy {
  [self.label setLineBreakStrategy:lineBreakStrategy];
}

- (NSAttributedString *)attributedText {
  return self.label.attributedText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
  [self.label setAttributedText:attributedText];
}

- (BOOL)isHighlighted {
  return [self.label isHighlighted];
}

- (void)setHighlighted:(BOOL)highlighted {
  [self.label setHighlighted:highlighted];
}

- (BOOL)isUserInteractionEnabled {
  return [self.label isUserInteractionEnabled];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
  [self.label setUserInteractionEnabled:userInteractionEnabled];
}

- (BOOL)isEnabled {
  return [self.label isEnabled];
}

- (void)setEnabled:(BOOL)enabled {
  [self.label setEnabled:enabled];
}

- (NSInteger)numberOfLines {
  return self.label.numberOfLines;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
  [self.label setNumberOfLines:numberOfLines];
}

- (BOOL)adjustsFontSizeToFitWidth {
  return self.label.adjustsFontSizeToFitWidth;
}

- (void)setAdjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth {
  [self.label setAdjustsFontSizeToFitWidth:adjustsFontSizeToFitWidth];
}

- (UIBaselineAdjustment)baselineAdjustment {
  return self.label.baselineAdjustment;
}

- (void)setBaselineAdjustment:(UIBaselineAdjustment)baselineAdjustment {
  [self.label setBaselineAdjustment:baselineAdjustment];
}

- (CGFloat)minimumScaleFactor {
  return self.label.minimumScaleFactor;
}

- (void)setMinimumScaleFactor:(CGFloat)minimumScaleFactor {
  [self.label setMinimumScaleFactor:minimumScaleFactor];
}

- (CGFloat)preferredMaxLayoutWidth {
  return self.label.preferredMaxLayoutWidth;
}

- (void)setPreferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth {
  [self.label setPreferredMaxLayoutWidth:preferredMaxLayoutWidth];
}

- (BOOL)allowsDefaultTighteningForTruncation {
  return self.label.allowsDefaultTighteningForTruncation;
}

- (void)setAllowsDefaultTighteningForTruncation:(BOOL)allowsDefaultTighteningForTruncation {
  [self.label setAllowsDefaultTighteningForTruncation:allowsDefaultTighteningForTruncation];
}

#pragma mark - Method

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
  return [self.label textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
}

- (void)drawTextInRect:(CGRect)rect {
  [self.label drawTextInRect:rect];
}

#pragma mark - UIContentSizeCategoryAdjusting

- (BOOL)adjustsFontForContentSizeCategory {
  return self.label.adjustsFontForContentSizeCategory;
}

- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  [self.label setAdjustsFontForContentSizeCategory:adjustsFontForContentSizeCategory];
}

#pragma mark - CPKLabelDelegate

- (void)labelDidFinishDrawText:(CPKLabel *)label {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self __updateDisplay];
  });
}

#pragma mark - Private

- (void)__setup {
  [self.layer addSublayer:self.displayLayer];
  [self addSubview:self.label];
}

- (void)__updateDisplay {
  if (self.label.text.length == 0) {
    [self.displayLayer setHidden:YES];
    [self.label setHidden:NO];
  }

  [self.displayLayer setHidden:YES];
  [self.label setHidden:NO];

  UIGraphicsImageRenderer *imageRenderer = [[UIGraphicsImageRenderer alloc] initWithBounds:self.label.bounds];
  UIImage *image = [imageRenderer imageWithActions:^(UIGraphicsImageRendererContext *context) {
    [self.label.layer renderInContext:context.CGContext];
  }];

  if (CGSizeEqualToSize(image.size, CGSizeZero)) {
    return;
  }

  dispatch_async(__dispatch_get_serial_queue(), ^{
    CVPixelBufferRef pixelBuffer;
    __CVPixelBufferCreateWithCGImage(image.CGImage, &pixelBuffer);

    CMSampleBufferRef sampleBuffer;
    __CMSampleBufferCreateReadyWithImageBuffer(pixelBuffer, &sampleBuffer);

    CVPixelBufferRelease(pixelBuffer);

    [self.displayLayer flush];
    [self.displayLayer enqueueSampleBuffer:sampleBuffer];

    dispatch_async(dispatch_get_main_queue(), ^{
      [self.label setHidden:YES];
      [self.displayLayer setHidden:NO];
    });
  });
}

#pragma mark - Lazy Properties

- (CPKLabel *)label {
  if (_label == nil) {
    _label = [CPKLabel new];
    [_label setDelegate:self];
  }
  return _label;
}

- (AVSampleBufferDisplayLayer *)displayLayer {
  if (_displayLayer == nil) {
    _displayLayer = [AVSampleBufferDisplayLayer new];
    [_displayLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    [_displayLayer setPreventsCapture:YES];
    [_displayLayer setActions:@{
      @"hidden": [NSNull null]
    }];
  }
  return _displayLayer;
}

@end
