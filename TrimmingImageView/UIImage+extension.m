//
//  UIImagePlus.m
//  growthRecord
//
//  Created by  on 12/05/10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

@implementation UIImage (extension)

- (UIImage *)shrinkImage:(CGSize)size
{
  CGFloat widthRatio  = size.width  / self.size.width;
  CGFloat heightRatio = size.height / self.size.height;
  CGFloat ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio;
  if (ratio >= 1.0) return self;
  CGRect rect = CGRectMake(0, 0,
                           self.size.width  * ratio,
                           self.size.height * ratio);
  
  UIGraphicsBeginImageContext(rect.size);
  [self drawInRect:rect];
  UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext(); 
  return shrinkedImage;
}

- (UIImage *)cutImage:(CGRect)rect
{
  CGImageRef cgImage = CGImageCreateWithImageInRect(self.CGImage, rect);
  UIImage *cutImage = [UIImage imageWithCGImage:cgImage];
  
  UIGraphicsBeginImageContext(rect.size);
  [cutImage drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  CGImageRelease(cgImage);
  
  return newImage;
}

@end