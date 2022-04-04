//
//  CPKSecureImageView.h
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

UIKIT_EXTERN API_AVAILABLE(ios(13.0)) NS_SWIFT_NAME(SecureImageView) NS_SWIFT_UI_ACTOR

/// An object that displays a single image with prevents capture.
@interface CPKSecureImageView : UIView

/// Returns an image view initialized with the specified image.
/// @param image The initial image to display in the image view. You may specify an image object that contains an animated sequence of images.
- (instancetype)initWithImage:(nullable UIImage *)image;

/// Returns an image view initialized with the specified regular and highlighted images.
/// @param image The initial image to display in the image view. You may specify an image object that contains an animated sequence of images.
/// @param highlightedImage The image to display when the image view is highlighted. You may specify an image object that contains an animated sequence of images.
- (instancetype)initWithImage:(nullable UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage;

/// The image displayed in the image view.
@property (nullable, nonatomic, strong) UIImage *image;

/// The highlighted image displayed in the image view.
@property (nullable, nonatomic, strong) UIImage *highlightedImage;

/// A Boolean value that determines whether the image is highlighted.
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

@end

NS_ASSUME_NONNULL_END
