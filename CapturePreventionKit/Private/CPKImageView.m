//
//  CPKImageView.m
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

#import "CPKImageView.h"

#pragma mark - __ImageViewLayer

@interface __ImageViewLayer : CALayer

@property (nullable, copy, nonatomic) void(^contentsDidChangeBlock)(void);

@end

@implementation __ImageViewLayer

- (void)setContents:(id)contents {
  id previousContents = self.contents;
  [super setContents:contents];
  if (previousContents != contents && self.contentsDidChangeBlock != nil) {
    self.contentsDidChangeBlock();
  }
}

@end

#pragma mark - CPKImageView

@implementation CPKImageView

- (void)setDelegate:(id<CPKImageViewDelegate>)delegate {
  _delegate = delegate;

  __weak typeof(self) weakSelf = self;
  __ImageViewLayer *imageViewLayer = (__ImageViewLayer *)self.layer;
  [imageViewLayer setContentsDidChangeBlock:^{
    [weakSelf.delegate imageViewDidChangeImage:weakSelf];
  }];
}

+ (Class)layerClass {
  return [__ImageViewLayer class];
}

@end
