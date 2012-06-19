//
//  EditViewController.m
//  TrimmingImageView
//
//  Created by tanaka on 12/05/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "UIImage+extension.h"

@interface MaskView : UIView
@end
@implementation MaskView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.opaque = NO;
  }
  return self;
}

- (void)drawRect:(CGRect)rect
{
  self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
  
  CGRect cRect = CGRectMake(0, 149, rect.size.width, 180);
  CGRect sRect = CGRectMake(0.5, 149, rect.size.width-1, 180);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.0f alpha:0.5f].CGColor);
  CGContextFillRect(context, rect);
  
  CGContextClearRect(context, cRect);
  
  CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0f alpha:0.4f].CGColor);
  CGContextSetLineWidth(context, 1.0);
  CGContextStrokeRect(context, sRect);
}

@end

@implementation EditViewController

@synthesize screen = _screen;
@synthesize iview = _iview;

- (id)initWithPickerImage:(UIImage *)data setInfo:(NSDictionary *)info
{
  self = [super init];
  if (self) {
    imageData = data;
    imageInfo = info;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _screen = [[UIScrollView alloc] initWithFrame:
             CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  
  _iview = [[UIImageView alloc] initWithImage:imageData];
  
  [self.view addSubview:_screen];
  [_screen addSubview:_iview];
  
  _screen.maximumZoomScale = 1.0;
  _screen.minimumZoomScale = 320/_iview.frame.size.width;
  _screen.clipsToBounds = NO;
  _screen.delegate = self;
  
  [_screen setZoomScale:_screen.minimumZoomScale];
  
  _screen.contentSize = _iview.frame.size;
  _screen.contentOffset = CGPointMake(0, -(self.view.frame.size.height/2-_iview.frame.size.height/2));
  _screen.contentInset = UIEdgeInsetsMake(149, 0, 131, 0);
  
  _screen.showsVerticalScrollIndicator = NO;
  _screen.showsHorizontalScrollIndicator = NO;
  
  MaskView *mask = [[MaskView alloc] initWithFrame:_screen.frame];
  [self.view addSubview:mask];
  mask.userInteractionEnabled = NO;
  
  UIBarButtonItem *spacer =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
  UIBarButtonItem *cancelBtn =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
  UIBarButtonItem *saveBtn =
  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
  
  self.toolbarItems = [NSArray arrayWithObjects:cancelBtn,spacer,saveBtn, nil];
  
  [mask release];
  [cancelBtn release];
  [saveBtn release];
  [spacer release];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
  self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
  [self.navigationController setToolbarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self.navigationController setToolbarHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollView delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return _iview;
}

#pragma mark - UIToolbar selector methods

- (void)save
{
  CGPoint offset = _screen.contentOffset;
  CGPoint point = _iview.frame.origin;
  NSLog(@"_screen.x = %f",point.x-offset.x);
  NSLog(@"_screen.y = %f",point.y-offset.y-149);
  NSLog(@"_screen.scale = %f",_screen.zoomScale);
  NSLog(@"iview.width = %f",_iview.frame.size.width);
  NSLog(@"iview.height = %f",_iview.frame.size.height);
  NSLog(@"/----------------------------------");
  float _x = (point.x-offset.x)/_screen.zoomScale;
  float _y = (point.y-offset.y-149)/_screen.zoomScale;
  float __x = (_x < 0)? _x*-1:_x;
  float __y = (_y < 0)? _y*-1:_y;
  float _w = 320/_screen.zoomScale;
  float _h = 180/_screen.zoomScale;
  NSLog(@"x = %f   y = %f   w = %f   h = %f",__x, __y, _w, _h);
  NSLog(@"/----------------------------------");
  
  UIImage *temp =
  [[[_iview.image cutImage:CGRectMake(__x, __y, _w, _h)] shrinkImage:CGSizeMake(1280, 720)] retain];
  
  [_iview removeFromSuperview];
  [_iview release];
  
  _iview = [[UIImageView alloc] initWithImage:temp];
  _screen.minimumZoomScale = 320/_iview.frame.size.width;
  [_screen setZoomScale:_screen.minimumZoomScale];
  [_screen addSubview:_iview];
  
  [temp release];
}

- (void)cancel
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end
