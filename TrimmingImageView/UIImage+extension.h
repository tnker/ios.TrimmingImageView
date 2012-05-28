//
//  UIImagePlus.h
//  growthRecord
//
//  Created by  on 12/05/10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (extension)
- (UIImage *)shrinkImage:(CGSize)size;  // reduction
- (UIImage *)cutImage; // trimming
- (UIImage *)cutImage:(CGRect)rect;
- (UIImage *)cutSquare:(CGSize)size;    // trimming square
- (UIImage *)cutRectangle:(CGSize)size; // trimming timeline
- (UIImage *)rotateImage:(int)angle;    // rotation
@end

