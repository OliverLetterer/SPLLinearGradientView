# SPLLinearGradientView

[![CI Status](http://img.shields.io/travis/Oliver Letterer/SPLLinearGradientView.svg?style=flat)](https://travis-ci.org/Oliver Letterer/SPLLinearGradientView)
[![Version](https://img.shields.io/cocoapods/v/SPLLinearGradientView.svg?style=flat)](http://cocoadocs.org/docsets/SPLLinearGradientView)
[![License](https://img.shields.io/cocoapods/l/SPLLinearGradientView.svg?style=flat)](http://cocoadocs.org/docsets/SPLLinearGradientView)
[![Platform](https://img.shields.io/cocoapods/p/SPLLinearGradientView.svg?style=flat)](http://cocoadocs.org/docsets/SPLLinearGradientView)

SPLLinearGradientView is a UIView subclass that draws a linear gradient.

## Usage

```
SPLLinearGradientView *gradientView = [[SPLLinearGradientView alloc] initWithFrame...];

gradientView.colors = @[ ... ];
[gradientView setColors:@[ ... ] atLocations:...];
```

## Installation

SPLLinearGradientView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "SPLLinearGradientView"

## Author

Oliver Letterer, oliver.letterer@gmail.com

## License

SPLLinearGradientView is available under the MIT license. See the LICENSE file for more info.
