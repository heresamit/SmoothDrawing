//
//  TDTViewController.h
//  Smooth Drawing
//
//  Created by Amit Chowdhary on 15/07/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmoothedBIView.h"

@interface TDTViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *lpgr;
@property (strong, nonatomic) IBOutlet SmoothedBIView *smoothDrawnView;

@end
