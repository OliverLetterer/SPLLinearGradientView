//
//  SPLLinearGradientView.h
//  Pods
//
//  Created by Oliver Letterer on 14.11.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//


/**
 Draws a linear gradient with `colors`.
 */
@interface SPLLinearGradientView : UIView

/**
 Must contain UIColor objects of the same color space. Will use equidistant locations.
 */
@property (nonatomic, retain) NSArray *colors;

/**
 Sets colors at specific locations.
 */
- (void)setColors:(NSArray *)colors atLocations:(CGFloat *)locations;

@end
