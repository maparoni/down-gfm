## down-gfm

[![Build Status](https://travis-ci.com/johnxnguyen/Down.svg?branch=master)](https://travis-ci.com/johnxnguyen/Down)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/johnxnguyen/Down/blob/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/Down)](https://cocoapods.org/pods/Down)
[![Swift 5](https://img.shields.io/badge/language-Swift-blue.svg)](https://swift.org)
[![macOS](https://img.shields.io/badge/OS-macOS-orange.svg)](https://developer.apple.com/macos/)
[![iOS](https://img.shields.io/badge/OS-iOS-orange.svg)](https://developer.apple.com/ios/)
[![tvOS](https://img.shields.io/badge/OS-tvOS-orange.svg)](https://developer.apple.com/tvos/)
[![Linux](https://img.shields.io/badge/OS-Linux-orange.svg)](https://www.linux.org/)
[![Code Coverage](https://codecov.io/gh/johnxnguyen/Down/branch/master/graph/badge.svg)](https://codecov.io/gh/johnxnguyen/Down)

Blazing fast rendering Markdown (Commonmark with selected GitHub-Flavored Markdown extensions) in Swift, built upon [cmark v0.28.3](https://github.com/github/cmark-gfm).

This is a fork of [`johnxnguyen/Down`](https://github.com/johnxnguyen/Down) from version 0.11.0.

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
```

### Differences to Down

For a full description of features, see [`johnxnguyen/Down`](https://github.com/johnxnguyen/Down).

This fork swaps cmark for cmark-gfm, and supports the following extensions:

- [x] Strikethrough
- [ ] Task lists
- [ ] Tables

### Supports

Swift; iOS 13+, tvOS 13+, macOS 10.15+

### Markdown Specification

Down is built upon the [CommonMark](http://commonmark.org) specification.

### A little help from my friends

Please feel free to fork and create a pull request for bug fixes or improvements, being sure to maintain the general coding style, adding tests, and adding comments as necessary.

### Credit

This library is a wrapper around [cmark](https://github.com/commonmark/cmark), which is built upon the [CommonMark](http://commonmark.org) Markdown specification.

[cmark](https://github.com/commonmark/cmark) is Copyright (c) 2014, John MacFarlane. View [full license](https://github.com/commonmark/cmark/blob/master/COPYING).
