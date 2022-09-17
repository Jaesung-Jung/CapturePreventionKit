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
    navigationItem.title = "Capture Prevention Kit"

    let scrollView = UIScrollView().then {
      $0.alwaysBounceVertical = true
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    view.addSubview(scrollView)
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])

    let headerLabel = SecureLabel().then {
      $0.text = "Prevent screen capture"
      $0.font = .preferredFont(forTextStyle: .title1)
      $0.adjustsFontForContentSizeCategory = true
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    scrollView.addSubview(headerLabel)
    NSLayoutConstraint.activate([
      headerLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
      headerLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
      headerLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
    ])

    let descriptionLabel = SecureLabel().then {
      $0.font = .preferredFont(forTextStyle: .body)
      $0.numberOfLines = 0
      $0.adjustsFontForContentSizeCategory = true
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.text = "Protect your security contents from screen capture on device. Labels and images provide protection from screen capture, screen recording and air play."
    }
    scrollView.addSubview(descriptionLabel)
    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
      descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
      descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
    ])

    let qrImageView = SecureImageView(image: UIImage(named: "qrcode")).then {
      $0.contentMode = .scaleAspectFit
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    scrollView.addSubview(qrImageView)
    NSLayoutConstraint.activate([
      qrImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
      qrImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      qrImageView.widthAnchor.constraint(equalToConstant: 200),
      qrImageView.heightAnchor.constraint(equalToConstant: 200)
    ])

    let qrLabel = UILabel().then {
      $0.text = "Scan QR Code"
      $0.textAlignment = .center
      $0.font = .boldSystemFont(ofSize: 20)
      $0.backgroundColor = .systemGroupedBackground
      $0.layer.cornerRadius = 16
      $0.layer.masksToBounds = true
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    scrollView.addSubview(qrLabel)
    NSLayoutConstraint.activate([
      qrLabel.topAnchor.constraint(equalTo: qrImageView.bottomAnchor, constant: 16),
      qrLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
      qrLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
      qrLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
      qrLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}
