//
//  CVPixelBufferSupport.m
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

#import "CVPixelBufferSupport.h"

CVReturn __CVPixelBufferCreateWithCGImage(CGImageRef _Nonnull image, CVPixelBufferRef _Nullable * _Nonnull pixelBufferOut) {
  // Create a Pixel Buffer
  size_t width = (NSInteger)CGImageGetWidth(image);
  size_t height = (NSInteger)CGImageGetHeight(image);

  NSDictionary *pixelBufferAttributes = @{
    (NSString *)kCVPixelBufferCGImageCompatibilityKey: @(YES),
    (NSString *)kCVPixelBufferCGBitmapContextCompatibilityKey: @(YES),
    (NSString *)kCVPixelBufferIOSurfacePropertiesKey: @{}
  };

  CVReturn result = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef)pixelBufferAttributes, pixelBufferOut);
  if (result != kCVReturnSuccess) {
    return result;
  }
  CVPixelBufferRef pixelBuffer = *pixelBufferOut;

  // Create a Color Space
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

  // Lock Pixel Buffer
  result = CVPixelBufferLockBaseAddress(pixelBuffer, 0);
  if (result != kCVReturnSuccess) {
    CVPixelBufferRelease(pixelBuffer);
    return result;
  }

  // Draw on Bitmap Context
  CGContextRef context = CGBitmapContextCreate(CVPixelBufferGetBaseAddress(pixelBuffer), width, height, 8, CVPixelBufferGetBytesPerRow(pixelBuffer), colorSpace, kCGImageAlphaPremultipliedFirst);
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
  CGContextRelease(context);

  // Release a Color Space
  CGColorSpaceRelease(colorSpace);

  // Unlock Pixel Buffer
  result = CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
  if (result != kCVReturnSuccess) {
    CVPixelBufferRelease(pixelBuffer);
    return result;
  }

  return kCVReturnSuccess;
}
