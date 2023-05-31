//
//  SecureLabel.swift
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

@available(iOS 13.0, tvOS 13.0, *)
@MainActor open class SecureLabel: UIView, UIContentSizeCategoryAdjusting {
  let secureTextField = UITextField()
  let label: Label

  open var text: String? {
    get { label.text }
    set { label.text = newValue }
  }

  open var font: UIFont! {
    get { label.font }
    set { label.font = newValue }
  }

  open var textColor: UIColor! {
    get { label.textColor }
    set { label.textColor = newValue }
  }

  open var shadowColor: UIColor? {
    get { label.shadowColor }
    set { label.shadowColor = newValue }
  }

  open var shadowOffset: CGSize {
    get { label.shadowOffset }
    set { label.shadowOffset = newValue }
  }

  open var textAlignment: NSTextAlignment {
    get { label.textAlignment }
    set { label.textAlignment = newValue }
  }

  open var lineBreakMode: NSLineBreakMode {
    get { label.lineBreakMode }
    set { label.lineBreakMode = newValue }
  }

  open var attributedText: NSAttributedString? {
    get { label.attributedText }
    set { label.attributedText = newValue }
  }

  open var isHighlighted: Bool {
    get { label.isHighlighted }
    set { label.isHighlighted = newValue }
  }

  open var isEnabled: Bool {
    get { label.isEnabled }
    set { label.isEnabled = newValue }
  }

  open var numberOfLines: Int {
    get { label.numberOfLines }
    set { label.numberOfLines = newValue }
  }

  open var adjustsFontSizeToFitWidth: Bool {
    get { label.adjustsFontSizeToFitWidth }
    set { label.adjustsFontSizeToFitWidth = newValue }
  }

  open var baselineAdjustment: UIBaselineAdjustment {
    get { label.baselineAdjustment }
    set { label.baselineAdjustment = newValue }
  }

  open var minimumScaleFactor: CGFloat {
    get { label.minimumScaleFactor }
    set { label.minimumScaleFactor = newValue }
  }

  open var allowsDefaultTighteningForTruncation: Bool {
    get { label.allowsDefaultTighteningForTruncation }
    set { label.allowsDefaultTighteningForTruncation = newValue }
  }

  @available(iOS 14.0, tvOS 14.0, *)
  open var ligntBreakStrategy: NSParagraphStyle.LineBreakStrategy {
    get { label.lineBreakStrategy }
    set { label.lineBreakStrategy = newValue }
  }

  open var preferredMaxLayoutWidth: CGFloat {
    get { label.preferredMaxLayoutWidth }
    set { label.preferredMaxLayoutWidth = newValue }
  }

  open var showsExpansionTextWhenTruncated: Bool {
    get { label.showsExpansionTextWhenTruncated }
    set { label.showsExpansionTextWhenTruncated = newValue }
  }

  open override var intrinsicContentSize: CGSize {
    return label.systemLayoutSizeFitting(bounds.size, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
  }

  open override var alignmentRectInsets: UIEdgeInsets { label.alignmentRectInsets }

  open override var forFirstBaselineLayout: UIView { label.forFirstBaselineLayout }

  open override var forLastBaselineLayout: UIView { label.forLastBaselineLayout }

  public var adjustsFontForContentSizeCategory: Bool {
    get { label.adjustsFontForContentSizeCategory }
    set { label.adjustsFontForContentSizeCategory = newValue }
  }

  public override init(frame: CGRect) {
    self.label = Label(frame: frame)
    super.init(frame: frame)
    setup()
  }

  public required init?(coder: NSCoder) {
    guard let label = Label(coder: coder) else {
      return nil
    }
    self.label = label
    super.init(coder: coder)
    setup()
  }

  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    return label.sizeThatFits(size)
  }

  open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    return label.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
  }

  open func drawText(in rect: CGRect) {
    label.drawText(in: rect)
  }

  open override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
    return label.systemLayoutSizeFitting(targetSize)
  }

  open override func systemLayoutSizeFitting(
    _ targetSize: CGSize, withHorizontalFittingPriority
    horizontalFittingPriority: UILayoutPriority,
    verticalFittingPriority: UILayoutPriority
  ) -> CGSize {
    return label.systemLayoutSizeFitting(
      targetSize, withHorizontalFittingPriority: horizontalFittingPriority,
      verticalFittingPriority: verticalFittingPriority
    )
  }

  open override func alignmentRect(forFrame frame: CGRect) -> CGRect {
    return label.alignmentRect(forFrame: frame)
  }

  open override func frame(forAlignmentRect alignmentRect: CGRect) -> CGRect {
    return label.frame(forAlignmentRect: alignmentRect)
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    label.frame = bounds
    invalidateIntrinsicContentSize()
  }
}

extension SecureLabel {
  func setup() {
    isUserInteractionEnabled = false

    secureTextField.isSecureTextEntry = true
    addSubview(secureTextField)
    layer.addSublayer(secureTextField.layer)

    secureTextField.layer.sublayers?.first?.addSublayer(label.layer)

    label.invalidate = { [weak self] in
      self?.invalidateIntrinsicContentSize()
    }
  }
}

// MARK: - SecureLabel.Label

extension SecureLabel {
  class Label: UILabel {
    var invalidate: (() -> Void)?

    override func invalidateIntrinsicContentSize() {
      super.invalidateIntrinsicContentSize()
      invalidate?()
    }
  }
}

#endif
