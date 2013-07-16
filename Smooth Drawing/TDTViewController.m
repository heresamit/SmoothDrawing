//
//  TDTViewController.m
//  Smooth Drawing
//
//  Created by Amit Chowdhary on 15/07/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTViewController.h"

@interface TDTViewController ()

@end

@implementation TDTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lpgr.minimumPressDuration = 1;
    [self.lpgr addTarget:self action:@selector(refreshView)];
}

- (void)refreshView {
  if (self.lpgr.state == UIGestureRecognizerStateBegan) {
    NSLog(@"YES");
    [self.smoothDrawnView eraseAll];
    [self.smoothDrawnView setNeedsDisplay];
  }
}
@end
