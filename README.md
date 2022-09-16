# Capture Prevention Kit

This package provides `Label` and `ImageView` for screen capture prevention. Usage is the same as `UIImageView` and `UILabel`.

It can be applied by changing `UILabel` to `SecureLabel` or `UIImageView` to `SecureImageView` without any special setting.

Since the process of converting to a sample buffer is required to output images or text, performance may be affected. It's recommended to apply only to important content.

## Requirement

iOS 13.0+

## Preview

![](https://raw.githubusercontent.com/Jaesung-Jung/CapturePreventionKit/main/preview.gif)

## Installation

Using Swift Package Manager

```
dependencies: [
  .package(url: "https://github.com/Jaesung-Jung/CapturePreventionKit.git", .upToNextMajor(from: "1.0.0"))
]
```

## License

MIT license. [See LICENSE](https://github.com/Jaesung-Jung/CapturePreventionKit/blob/main/LICENSE) for details.
