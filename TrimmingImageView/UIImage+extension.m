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
  
//  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
  UIGraphicsBeginImageContext(rect.size);
  [self drawInRect:rect];
  UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext(); 
  return shrinkedImage;
}

- (UIImage *)cutImage
{
  UIImage *cutImage = self;
  float fResizeHeight = cutImage.size.height / 1.3333 * 0.9;//横の右を切り捨てるので0.9かけている
  float fResizeWidth = cutImage.size.width * 0.9; //右側の0.1は写真にしない
  float fStartX = cutImage.size.width * 0.05; //スタート位置
  
  CGImageRef cgImage = CGImageCreateWithImageInRect(cutImage.CGImage, CGRectMake(fStartX,0,cutImage.size.width+fStartX,cutImage.size.height));
  cutImage = [UIImage imageWithCGImage:cgImage];
  
  CGRect cutRect = CGRectMake(0, (fResizeHeight-cutImage.size.height)/2, fResizeWidth, fResizeHeight); 
  UIGraphicsBeginImageContext(cutRect.size);
  [cutImage drawAtPoint:cutRect.origin];
  cutImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext(); 
  
  CGImageRelease(cgImage);
  
  return cutImage;
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

- (UIImage *)cutSquare:(CGSize)size
{
  float w = self.size.width;
  float h = self.size.height;
  CGRect rect;
  if (h <= w) {
    float x = w/2-h/2;
    float y = 0;
    rect = CGRectMake(x, y, h, h);
  } else {
    float x = 0;
    float y = h/2-w/2;
    rect = CGRectMake(x, y, w, w);
  }
  CGImageRef cgImage = CGImageCreateWithImageInRect(self.CGImage, rect);
  UIImage *thumbnailImage = [UIImage imageWithCGImage:cgImage];
  
  UIGraphicsBeginImageContext(size);
  [thumbnailImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  CGImageRelease(cgImage);
  
  return newImage;
}

- (UIImage *)cutRectangle:(CGSize)size
{
  float w = self.size.width;
  float h = self.size.height;
  CGRect rect;
  
  float x = 0;
  float y = h/2-((w*size.height)/size.width)/2;
  
  rect = CGRectMake(x, y, w, (w*size.height)/size.width);
  
  CGImageRef cgImage = CGImageCreateWithImageInRect(self.CGImage, rect);
  UIImage *thumbnailImage = [UIImage imageWithCGImage:cgImage];
  
  UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height+10));
  CGContextSetShadow(UIGraphicsGetCurrentContext(), CGSizeMake(0.0f, 2.0f), 4.0f);
  [thumbnailImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  CGImageRelease(cgImage);
  
  return newImage;
}

- (UIImage *)rotateImage:(int)angle
{
  CGImageRef imgRef = [self CGImage];
  CGContextRef context;
  switch (angle) {
    case 0:
      UIGraphicsBeginImageContext(CGSizeMake(self.size.width, self.size.height));
      context = UIGraphicsGetCurrentContext();
      CGContextTranslateCTM(context, self.size.width, 0);
      CGContextScaleCTM(context, 1.0, -1.0);
      CGContextRotateCTM(context, -M_PI);
      break;
    case 90:
      UIGraphicsBeginImageContext(CGSizeMake(self.size.height, self.size.width));
      context = UIGraphicsGetCurrentContext();
      CGContextTranslateCTM(context, self.size.height, self.size.width);
      CGContextScaleCTM(context, 1.0, -1.0);
      CGContextRotateCTM(context, M_PI/2.0);
      break;
    case 180:
      UIGraphicsBeginImageContext(CGSizeMake(self.size.width, self.size.height));
      context = UIGraphicsGetCurrentContext();
      CGContextTranslateCTM(context, self.size.width, 0);
      CGContextScaleCTM(context, 1.0, -1.0);
      CGContextRotateCTM(context, -M_PI);
      break;
    case 270:
      UIGraphicsBeginImageContext(CGSizeMake(self.size.height, self.size.width));
      context = UIGraphicsGetCurrentContext();
      CGContextScaleCTM(context, 1.0, -1.0);
      CGContextRotateCTM(context, -M_PI/2.0);
      break;
    default:
      NSLog(@"you can select an angle of 90, 180, 270");
      return nil;
  }  
  CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), imgRef);
  UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();  
  UIGraphicsEndImageContext();
  return ret;
}



@end