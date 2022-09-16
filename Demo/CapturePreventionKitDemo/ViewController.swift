//
//  ViewController.swift
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

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    navigationItem.title = "Capture Prevention Kit"

    let headerLabel = SecureLabel()
    headerLabel.text = "Prevent screen capture"
    headerLabel.font = .preferredFont(forTextStyle: .title1)
    headerLabel.adjustsFontForContentSizeCategory = true

    let descriptionLabel = SecureLabel()
    descriptionLabel.text = "Protect your security contents from screen capture on device. Labels and images provide protection from screen capture, screen recording and air play."
    descriptionLabel.font = .preferredFont(forTextStyle: .body)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.adjustsFontForContentSizeCategory = true

    let labelStackView = UIStackView(axis: .vertical, spacing: 8, arrangedSubviews: [
      headerLabel,
      descriptionLabel
    ])
    labelStackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(labelStackView)
    NSLayoutConstraint.activate([
      labelStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      labelStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      labelStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
    ])

    let qrImageView = SecureImageView(image: UIImage(named: "qrcode"))
    qrImageView.contentMode = .scaleAspectFit
    qrImageView.translatesAutoresizingMaskIntoConstraints = false

    let qrLabel = UILabel()
    qrLabel.text = "Scan QR Code"
    qrLabel.textAlignment = .center
    qrLabel.font = .boldSystemFont(ofSize: 20)
    qrLabel.backgroundColor = .systemGroupedBackground
    qrLabel.translatesAutoresizingMaskIntoConstraints = false
    qrLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    qrLabel.layer.cornerRadius = 16
    qrLabel.layer.masksToBounds = true


    view.addSubview(qrImageView)
    view.addSubview(qrLabel)

    NSLayoutConstraint.activate([
      qrImageView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 40),
      qrImageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
      qrImageView.widthAnchor.constraint(equalToConstant: 200),
      qrImageView.heightAnchor.constraint(equalToConstant: 200),

      qrLabel.topAnchor.constraint(equalTo: qrImageView.bottomAnchor, constant: 16),
      qrLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      qrLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
    ])
  }
}
