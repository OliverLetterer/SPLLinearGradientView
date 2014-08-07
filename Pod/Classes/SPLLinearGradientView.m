/**
  SPLLinearGradientView
  Copyright (c) 2014 Oliver Letterer <oliver.letterer@gmail.com>, Sparrow-Labs

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/

#import "SPLLinearGradientView.h"



@interface SPLLinearGradientView ()

@property (nonatomic, assign) CGGradientRef gradient;

@end



@implementation SPLLinearGradientView

#pragma mark - setters and getters

- (void)setColors:(NSArray *)colors
{
    // calculate the locations, at which the gradient will align its colors
    CGFloat numberOfColors = (CGFloat) _colors.count;
    CGFloat *locations = malloc(sizeof(CGFloat) * numberOfColors);
    for (int i = 0; i < numberOfColors; i++) {
        locations[i] = ((CGFloat)i) / (numberOfColors - 1);
    }

    [self setColors:colors atLocations:locations];

    free(locations);
}

- (void)setColors:(NSArray *)colors atLocations:(CGFloat *)locations
{
    _colors = colors;

    if (_gradient != NULL) {
        CGGradientRelease(_gradient), _gradient = NULL;
    }

    CGColorSpaceRef colorSpace = NULL;

    NSMutableArray *CGColorsArray = [NSMutableArray arrayWithCapacity:_colors.count];
    for (UIColor *color in _colors) {
        [CGColorsArray addObject:(id)color.CGColor];
        colorSpace = CGColorGetColorSpace(color.CGColor);
    }

    _gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)CGColorsArray, locations);

    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
    CGRect bounds = self.bounds;
    [super setFrame:frame];
    if (!CGRectEqualToRect(bounds, self.bounds)) {
        [self setNeedsDisplay];
    }
}

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.layer.opaque = NO;
        self.layer.needsDisplayOnBoundsChange = YES;
        self.colors = @[ [UIColor colorWithRed:240.0 / 255.0 green:240.0 / 255.0 blue:240.0 / 255.0 alpha:1.0], [UIColor colorWithRed:192.0 /255.0 green:192.0 /255.0 blue:192.0 /255.0 alpha:1.0]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (!_gradient) {
        return;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawLinearGradient(context, _gradient,
                                CGPointMake(CGRectGetWidth(self.bounds) / 2.0, 0.0),
                                CGPointMake(CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds)),
                                0.0);
}

#pragma mark - Memory management

- (void)dealloc
{
    if (_gradient) {
        CGGradientRelease(_gradient), _gradient = NULL;
    }
}

@end
