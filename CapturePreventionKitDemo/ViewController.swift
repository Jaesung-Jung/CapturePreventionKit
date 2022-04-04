//
//  ViewController.swift
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

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    let imageView = UIImageView(image: #imageLiteral(resourceName: "swift"))
    let label = UILabel()
    label.text = "UILabel with UIImageView 😀"
    label.textColor = .white
    label.backgroundColor = .systemBlue
    label.textAlignment = .center

    let leftStackView = UIStackView(
      arrangedSubviews: [
        imageView,
        label
      ]
    )
    leftStackView.axis = .vertical
    leftStackView.spacing = 20
    leftStackView.alignment = .center

    let secureImageView = SecureImageView(image: #imageLiteral(resourceName: "swift"))
    let secureLabel = SecureLabel()
    secureLabel.text = "SecureLabel with SecureImageView 🫣"
    secureLabel.textColor = .white
    secureLabel.backgroundColor = .systemGreen
    secureLabel.textAlignment = .center

    let rightStackView = UIStackView(
      arrangedSubviews: [
        secureImageView,
        secureLabel
      ]
    )
    rightStackView.axis = .vertical
    rightStackView.spacing = 20
    rightStackView.alignment = .center

    let stackView = UIStackView(
      arrangedSubviews: [
        leftStackView,
        rightStackView
      ]
    )
    stackView.axis = .vertical
    stackView.spacing = 50
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
      stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
