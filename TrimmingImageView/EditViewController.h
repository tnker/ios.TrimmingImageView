//
//  EditViewController.h
//  GrowthRecordApp
//
//  Created by tanaka on 12/05/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController
<UIScrollViewDelegate>
{
  UIImage *imageData;
  NSDictionary *imageInfo;
}

@property (nonatomic, retain) UIScrollView *screen;
@property (nonatomic, retain) UIImageView *iview;

- (id)initWithPickerImage:(UIImage *)data setInfo:(NSDictionary *)info;

@end
