//
//  ViewController.m
//  TrimmingImageView
//
//  Created by Tanaka Yuuya on 12/05/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "EditViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

#pragma mark - IBAction methods

- (void)showPicker:(id)sender
{
  NSLog(@"show picker");
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
    UIImagePickerController *pk = [[[UIImagePickerController alloc] init] autorelease];
    pk.delegate = self;
    pk.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:pk animated:YES];
  }
}

#pragma mark - UIImagePicker delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
  EditViewController *editController =
  [[EditViewController alloc] initWithPickerImage:image setInfo:editingInfo];
  [picker pushViewController:editController animated:YES];
  [editController release];
}

@end
