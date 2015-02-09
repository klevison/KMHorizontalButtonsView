//
//  ViewController.h
//  BubbleButtonView
//
//  Created by Benjamin Gordon on 11/27/12.
//  Copyright (c) 2012 Benjamin Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> // Don't forget QuartzCore
#import "KMHorizontalButtonsView.h"

@interface ViewController : UIViewController <KMHorizontalButtonsViewDelegate> {
    // View that holds bubble buttons
    __weak IBOutlet KMHorizontalButtonsView *bubbleView;
    
    // Main Button
    __weak IBOutlet UIButton *mainButton;
}

// IBAction for demo purposes
- (IBAction)addButtons:(id)sender;

@end
