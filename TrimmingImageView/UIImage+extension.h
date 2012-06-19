//
//  UIImagePlus.h
//  TrimmingImageView
//
//  Created by  on 12/05/10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (extension)
- (UIImage *)shrinkImage:(CGSize)size;
- (UIImage *)cutImage:(CGRect)rect;
@end

