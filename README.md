## down-gfm

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/maparoni/down-gfm/blob/master/LICENSE)
[![Swift 5](https://img.shields.io/badge/language-Swift-blue.svg)](https://swift.org)
[![macOS](https://img.shields.io/badge/OS-macOS-orange.svg)](https://developer.apple.com/macos/)
[![iOS](https://img.shields.io/badge/OS-iOS-orange.svg)](https://developer.apple.com/ios/)
[![tvOS](https://img.shields.io/badge/OS-tvOS-orange.svg)](https://developer.apple.com/tvos/)
[![Linux](https://img.shields.io/badge/OS-Linux-orange.svg)](https://www.linux.org/)
[![Code Coverage](https://codecov.io/gh/johnxnguyen/Down/branch/master/graph/badge.svg)](https://codecov.io/gh/johnxnguyen/Down)

Blazing fast rendering Markdown (GitHub-Flavored Markdown) in Swift, powered by:

- [github/cmark-gfm](https://github.com/github/cmark-gfm)
- [apple/swift-cmark](https://github.com/apple/swift-cmark)
- [apple/swift-markdown](https://github.com/apple/swift-markdown)

This is a fork of [`johnxnguyen/Down`](https://github.com/johnxnguyen/Down) from version 0.11.0, swapping the embedded cmark files for the above dependencies.

**WARNING: Currently missing from this fork, see #2:**
- **Support for ordered lists that don't start at 1.**
- **`DownOptions` that reflect cmark options**


#### Maintainers

down-gfm maintainers

- [Adrian Schönig](https://github.com/nighthawk)

Down maintainers

- [John Nguyen](https://github.com/johnxnguyen)
- [Rob Phillips](https://github.com/iwasrobbed)
- [Keaton Burleson](https://github.com/128keaton)
- [phoney](https://github.com/phoney)
- [Tony Arnold](https://github.com/tonyarnold)
- [Ken Harris](https://github.com/kengruven)
- [Chris Zielinski](https://github.com/chriszielinski)
- [Other contributors](https://github.com/johnxnguyen/Down/graphs/contributors) 🙌

### Installation

This fork only maintains compatibility with Swift 5.5 and above, and the
[Swift Package Manager](https://github.com/apple/swift-package-manager).

```swift
        .package(url: "https://github.com/maparoni/down-gfm.git", .branch("gfm")),
```

### Differences to Down

This fork swaps cmark for cmark-gfm, and supports the GFM-extensions, with the notable exception that **tables** are not supported when using NSAttributedString.

For a full description of features, see [`johnxnguyen/Down`](https://github.com/johnxnguyen/Down).

### Supports

Swift; iOS 13+, tvOS 13+, macOS 10.15+

### Markdown Specification

down-gfm is built upon the [GitHub-Flavored Markdown](https://github.github.com/gfm/) specification.

### A little help from my friends

Please feel free to fork and create a pull request for bug fixes or improvements, being sure to maintain the general coding style, adding tests, and adding comments as necessary.

### Credits

- [`johnxnguyen/Down`](https://github.com/johnxnguyen/Down)
- [apple/swift-markdown](https://github.com/apple/swift-markdown)
- [apple/swift-cmark](https://github.com/apple/swift-cmark)
- [github/cmark-gfm](https://github.com/github/cmark-gfm)
- [cmark](https://github.com/commonmark/cmark)
