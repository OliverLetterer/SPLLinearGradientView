//
//  SPLLinearGradientView.m
//  Pods
//
//  Created by Oliver Letterer on 14.11.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SPLLinearGradientView.h"



@interface SPLLinearGradientView () {
    
}

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
        self.colors = @[ [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f], [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f]];
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
                                CGPointMake(CGRectGetWidth(self.bounds) / 2.0f, 0.0f),
                                CGPointMake(CGRectGetWidth(self.bounds) / 2.0f, CGRectGetHeight(self.bounds)),
                                0.0f);
}

#pragma mark - Memory management

- (void)dealloc
{
    if (_gradient) {
        CGGradientRelease(_gradient), _gradient = NULL;
    }
}

@end
