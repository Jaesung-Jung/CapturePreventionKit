//
//  SecureImageView.swift
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

#if canImport(UIKit)

import UIKit
import AVFoundation

/// An object that displays a single image with prevents capture.
@available(iOS 13.0, tvOS 13.0, *)
@MainActor open class SecureImageView: UIView {
  let queue = DispatchQueue(label: "secure-image-view")

  let imageView: ImageView

  let displayLayer: AVSampleBufferDisplayLayer = {
    let layer = AVSampleBufferDisplayLayer()
    layer.videoGravity = .resize
    layer.preventsCapture = true
    layer.actions = ["hidden": NSNull()]
    return layer
  }()

  /// The image displayed in the image view.
  open var image: UIImage? {
    get { imageView.image }
    set { imageView.image = newValue }
  }

  /// The highlighted image displayed in the image view.
  open var highlightedImage: UIImage? {
    get { imageView.highlightedImage }
    set { imageView.highlightedImage = newValue }
  }

  /// A Boolean value that determines whether the image is highlighted.
  open var isHighlighted: Bool {
    get { imageView.isHighlighted }
    set { imageView.isHighlighted = newValue }
  }

  open override var intrinsicContentSize: CGSize { imageView.intrinsicContentSize }

  open override var contentMode: UIView.ContentMode {
    didSet {
      switch contentMode {
      case .scaleAspectFit:
        displayLayer.videoGravity = .resizeAspect
      case .scaleAspectFill:
        displayLayer.videoGravity = .resizeAspectFill
      default:
        displayLayer.videoGravity = .resize
      }
      imageView.contentMode = contentMode
    }
  }

  /// Returns an image view initialized with the specified image.
  /// - Parameters:
  ///   - image: The initial image to display in the image view. You may specify an image object that contains an animated sequence of images.
  ///   - highlightedImage: The image to display when the image view is highlighted. You may specify an image object that contains an animated sequence of images.
  public init(image: UIImage?, highlightedImage: UIImage? = nil) {
    self.imageView = ImageView(image: image, highlightedImage: highlightedImage)
    super.init(frame: .zero)
    _setup()
  }

  public override init(frame: CGRect) {
    self.imageView = ImageView(frame: frame)
    super.init(frame: frame)
    _setup()
  }

  public required init?(coder: NSCoder) {
    guard let imageView = ImageView(coder: coder) else {
      return nil
    }
    self.imageView = imageView
    super.init(coder: coder)
    _setup()
  }

  open override func setNeedsDisplay() {
    super.setNeedsDisplay()
    _updateDisplay()
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = bounds
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    displayLayer.frame = bounds
    CATransaction.commit()
  }

  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    return imageView.sizeThatFits(size)
  }

  open override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
    return imageView.systemLayoutSizeFitting(targetSize)
  }

  open override func systemLayoutSizeFitting(
    _ targetSize: CGSize, withHorizontalFittingPriority
    horizontalFittingPriority: UILayoutPriority,
    verticalFittingPriority: UILayoutPriority
  ) -> CGSize {
    return imageView.systemLayoutSizeFitting(
      targetSize, withHorizontalFittingPriority: horizontalFittingPriority,
      verticalFittingPriority: verticalFittingPriority
    )
  }

  open override func alignmentRect(forFrame frame: CGRect) -> CGRect {
    return imageView.alignmentRect(forFrame: frame)
  }

  open override func frame(forAlignmentRect alignmentRect: CGRect) -> CGRect {
    return imageView.frame(forAlignmentRect: alignmentRect)
  }
}

extension SecureImageView {
  private func _setup() {
    isUserInteractionEnabled = false
    layer.addSublayer(displayLayer)

    addSubview(imageView)
    imageView.contentsDidChange = { [weak self] in
      self?._updateDisplay()
    }
  }

  private func _updateDisplay() {
    if let highlightedImage = highlightedImage, isHighlighted {
      _updateDisplay(image: highlightedImage)
    } else {
      _updateDisplay(image: image)
    }
  }

  private func _updateDisplay(image: UIImage?) {
    guard let image = image?.cgImage else {
      displayLayer.isHidden = true
      imageView.isHidden = true
      return
    }

    displayLayer.isHidden = true
    imageView.isHidden = false

    queue.async {
      guard let imageBuffer = CVPixelBuffer.pixelBuffer(image: image) else {
        return
      }
      guard let sampleBuffer = try? CMSampleBuffer.sampleBuffer(imageBuffer: imageBuffer) else {
        return
      }

      self.displayLayer.flush()
      self.displayLayer.enqueue(sampleBuffer)

      DispatchQueue.main.async {
        self.displayLayer.isHidden = false
        self.imageView.isHidden = true
      }
    }
  }
}

#endif
