//
//  CPKSecureImageView.m
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

#import "CPKSecureImageView.h"
#import "CPKImageView.h"
#import "CVPixelBufferSupport.h"
#import "CMSampleBufferSupport.h"
#import "CPKQueue.h"

@interface CPKSecureImageView () <CPKImageViewDelegate>

@property (nonnull, strong, nonatomic) CPKImageView *imageView;
@property (nonnull, strong, nonatomic) AVSampleBufferDisplayLayer *displayLayer;

@end

@implementation CPKSecureImageView

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

- (instancetype)initWithImage:(nullable UIImage *)image {
  if (self = [super initWithFrame:CGRectZero]) {
    [self.imageView setImage:image];
    [self __setup];
  }
  return self;
}

- (instancetype)initWithImage:(nullable UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage {
  if (self = [super initWithFrame:CGRectZero]) {
    [self.imageView setImage:image];
    [self.imageView setHighlighted:image];
    [self __setup];
  }
  return self;
}

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  if ([self isHighlighted] && self.highlightedImage != nil) {
    [self __updateDisplayWithImage:self.highlightedImage];
  } else {
    [self __updateDisplayWithImage:self.image];
  }
}

#pragma mark - Override

- (CGSize)intrinsicContentSize {
  return self.imageView.intrinsicContentSize;
}

- (UIViewContentMode)contentMode {
  return self.imageView.contentMode;
}

- (void)setContentMode:(UIViewContentMode)contentMode {
  switch (contentMode) {
    case UIViewContentModeScaleToFill:
      [self.displayLayer setVideoGravity:AVLayerVideoGravityResize];
      [self.imageView setContentMode:UIViewContentModeScaleToFill];
      break;
    case UIViewContentModeScaleAspectFit:
      [self.displayLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
      [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
      break;
    case UIViewContentModeScaleAspectFill:
      [self.displayLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
      [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
      break;
    default:
      [self.displayLayer setVideoGravity:AVLayerVideoGravityResize];
      [self.imageView setContentMode:UIViewContentModeScaleToFill];
      break;
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self.imageView setFrame:self.bounds];
  [self.displayLayer setFrame:self.bounds];
}

#pragma mark - Property

- (UIImage *)image {
  return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
  [self.imageView setImage:image];
}

- (UIImage *)highlightedImage {
  return self.imageView.highlightedImage;
}

- (void)setHighlightedImage:(UIImage *)highlightedImage {
  [self.imageView setHighlightedImage:highlightedImage];
}

- (BOOL)isHighlighted {
  return [self.imageView isHighlighted];
}

- (void)setHighlighted:(BOOL)highlighted {
  [self.imageView setHighlighted:highlighted];
}

#pragma mark - CPKImageViewDelegate

- (void)imageViewDidChangeImage:(CPKImageView *)imageView {
  if ([self.imageView isHighlighted] && self.highlightedImage != nil) {
    [self __updateDisplayWithImage:self.highlightedImage];
  } else {
    [self __updateDisplayWithImage:self.image];
  }
}

#pragma mark - Private

- (void)__setup {
  [self.layer addSublayer:self.displayLayer];
  [self addSubview:self.imageView];
  [self setUserInteractionEnabled:NO];
}

- (void)__updateDisplayWithImage:(UIImage *)image {
  if (image == nil) {
    [self.displayLayer setHidden:YES];
    [self.imageView setHidden:NO];
    return;
  }

  [self.displayLayer setHidden:YES];
  [self.imageView setHidden:NO];

  dispatch_async(__dispatch_get_serial_queue(), ^{
    CVPixelBufferRef pixelBuffer;
    __CVPixelBufferCreateWithCGImage(image.CGImage, &pixelBuffer);

    CMSampleBufferRef sampleBuffer;
    __CMSampleBufferCreateReadyWithImageBuffer(pixelBuffer, &sampleBuffer);

    CVPixelBufferRelease(pixelBuffer);

    [self.displayLayer flush];
    [self.displayLayer enqueueSampleBuffer:sampleBuffer];

    dispatch_async(dispatch_get_main_queue(), ^{
      [self.imageView setHidden:YES];
      [self.displayLayer setHidden:NO];
    });
  });
}

#pragma mark - Lazy Properties

- (CPKImageView *)imageView {
  if (_imageView == nil) {
    _imageView = [CPKImageView new];
    [_imageView setDelegate:self];
  }
  return _imageView;
}

- (AVSampleBufferDisplayLayer *)displayLayer {
  if (_displayLayer == nil) {
    _displayLayer = [AVSampleBufferDisplayLayer new];
    [_displayLayer setVideoGravity:AVLayerVideoGravityResize];
    [_displayLayer setPreventsCapture:YES];
    [_displayLayer setActions:@{
      @"hidden": [NSNull null]
    }];
  }
  return _displayLayer;
}

@end
