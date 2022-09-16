//
//  CVPixelBufferExtension.swift
//
//  Copyright © 2022 Jaesung Jung. All rights reserved.
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

import CoreVideo

extension CVPixelBuffer {
  static func pixelBuffer(image: CGImage) -> CVPixelBuffer? {
    // Create a Pixel Buffer
    let attributes: [CFString: Any] = [
      kCVPixelBufferCGImageCompatibilityKey: true,
      kCVPixelBufferCGBitmapContextCompatibilityKey: true,
      kCVPixelBufferIOSurfacePropertiesKey: [:]
    ]

    var pixelBuffer: CVPixelBuffer?
    guard CVPixelBufferCreate(kCFAllocatorDefault, image.width, image.height, kCVPixelFormatType_32ARGB, attributes as CFDictionary, &pixelBuffer) == kCVReturnSuccess else {
      return nil
    }
    guard let pixelBuffer = pixelBuffer else {
      return nil
    }

    // Lock Pixel Buffer
    CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)

    // Draw on Bitmap Context

    let context = CGContext(
      data: CVPixelBufferGetBaseAddress(pixelBuffer),
      width: image.width,
      height: image.height,
      bitsPerComponent: 8,
      bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
      space: CGColorSpaceCreateDeviceRGB(),
      bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
    )
    context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))

    // Unlock Pixel Buffer
    CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)

    return pixelBuffer
  }
}
