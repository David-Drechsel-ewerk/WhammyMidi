//
//  DelayedButtonViewController.m
//  MIDITest
//
//  Created by David Drechsel on 27.03.13.
//  Copyright (c) 2013 David Drechsel. All rights reserved.
//

#import "DelayedButtonViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DelayedButtonViewController ()
{
  IBOutlet UIImageView *imageView;
  IBOutlet UILabel *textLbl;
  NSTimer *delayTimer;
}

@end

@implementation DelayedButtonViewController
@synthesize image = _image, delegate = _delegate, btnFiredSelector = _btnFiredSelector, delay = _delay, text = _text;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.delay = 0.7f;
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
  imageView.image = self.image;
  textLbl.text = self.text;
  CALayer *layer = self.view.layer;
  layer.borderColor = kBaseColor.CGColor;
  layer.borderWidth = 0;
  layer.cornerRadius = 8;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark setters
-(void)setImage:(UIImage *)anImage
{
  if (_image != anImage)
  {
    _image = nil;
    _image = anImage;
  }
  
  imageView.image = _image;
}

-(void)setText:(NSString *)aText
{
  if (_text != aText)
  {
    _text = nil;
    _text = aText;
  }
  
  textLbl.text = _text;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  delayTimer = [NSTimer scheduledTimerWithTimeInterval:self.delay target:self selector:@selector(fire) userInfo:nil repeats:NO];
  
  CALayer *layer = self.view.layer;
  layer.backgroundColor = kHighlightColor.CGColor;
  layer.borderWidth = 2;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [delayTimer invalidate];
  delayTimer = nil;
  
  CALayer *layer = self.view.layer;
  layer.backgroundColor = [UIColor clearColor].CGColor;
  layer.borderWidth = 0;
}

-(void)fire
{
  [delayTimer invalidate];
  delayTimer = nil;
  if ([self.delegate respondsToSelector:self.btnFiredSelector])
  {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.delegate performSelector:self.btnFiredSelector withObject:self];
    #pragma clang diagnostic pop
  }
}

@end
