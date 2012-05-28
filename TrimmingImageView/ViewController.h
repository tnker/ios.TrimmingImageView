//
//  ViewController.h
//  TrimmingImageView
//
//  Created by Tanaka Yuuya on 12/05/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)showPicker:(id)sender;

@end
