//
//  BBView.m
//  BubbleButtonView
//
//  Created by Benjamin Gordon on 1/8/13.
//  Copyright (c) 2013 Benjamin Gordon. All rights reserved.
//

#import "KMHorizontalButtonsView.h"
#import <QuartzCore/QuartzCore.h>

@interface KMHorizontalButtonsView ()

@property BOOL shouldResizeToFitSubviews;

@end

@implementation KMHorizontalButtonsView

#pragma mark - Bubble Button Methods

- (void)fillBubbleViewWithButtons:(NSArray *)strings bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor fontName:(NSString *)fontName fontSize:(CGFloat)fsize applyShadow:(BOOL)applyShadow animated:(BOOL)animated resizeToFitSubviews:(BOOL)resizeToFitSubviews
{
    self.shouldResizeToFitSubviews = resizeToFitSubviews;
    self.bubbleButtonArray = [NSMutableArray array];
    UIFont *buttonFont = [UIFont fontWithName:fontName size:fsize];
    
    CGFloat ftime = 0.034;
    if (!animated) {
        ftime = 0;
    }
        
    // Create padding between sides of view and each button
    //  -- I recommend 10 for aesthetically pleasing results at a 14 fontSize
    NSInteger pad = 10;
    
    // Iterate over every string in the array to create the Bubble Button
    for (int xx = 0; xx < strings.count; xx++) {
        
        // Find the size of the button, turn it into a rect
        NSString *bub = [strings objectAtIndex:xx];
        CGSize bSize = [bub sizeWithFont:buttonFont constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect buttonRect = CGRectMake(pad, pad, bSize.width + fsize, bSize.height + fsize/2);
        
        
        // if new button will fit on screen, in row:
        //   - place it
        // else:
        //   - put on next row at beginning
        if (xx > 0) {
            UIButton *oldButton = [[self subviews] objectAtIndex:self.subviews.count - 1];
            if ((oldButton.frame.origin.x + (2*pad) + oldButton.frame.size.width + bSize.width + fsize) > self.frame.size.width) {
                buttonRect = CGRectMake(pad, oldButton.frame.origin.y + oldButton.frame.size.height + pad, bSize.width + fsize, bSize.height + fsize/2);
            }
            else {
                buttonRect = CGRectMake(oldButton.frame.origin.x + pad + oldButton.frame.size.width, oldButton.frame.origin.y, bSize.width + fsize, bSize.height + fsize/2);
            }
        }
        
        
        // Create button and make magic with the UI
        // -- Set the alpha to 0, cause we're gonna' animate them at the end
        UIButton *bButton = [[UIButton alloc] initWithFrame:buttonRect];
        [bButton setShowsTouchWhenHighlighted:NO];
        [bButton setTitle:bub forState:UIControlStateNormal];
        [bButton.titleLabel setFont:buttonFont];
        [bButton setTitleColor:textColor forState:UIControlStateNormal];
        [bButton setBackgroundColor:bgColor];
        bButton.layer.cornerRadius = (3*fsize/4);
        [bButton setAlpha:0];
        
        // Give it some data and a target
        bButton.tag = xx;
        [bButton addTarget:self action:@selector(clickedBubbleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (applyShadow) {
            // And finally add a shadow if needed
            [self applyShadowToButton:bButton fontSize:fsize];
        }
        
        // Add to the view, and to the array
        [self addSubview:bButton];
        [self.bubbleButtonArray addObject:bButton];
    }
    
    // Sequentially animate the buttons appearing in view
    // -- This is the interval between each button animating, not overall span
    // -- I recommend 0.034 for an nice, smooth transition
    [self addBubbleButtonsWithInterval:ftime animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.shouldResizeToFitSubviews) {
        [self resizeToFitSubviews];
    }
}

- (void)applyShadowToButton:(UIButton *)bButton fontSize:(CGFloat)fsize
{
    
    bButton.layer.shadowColor = [[UIColor blackColor] CGColor];
    bButton.layer.shadowOffset = CGSizeMake(0.0f, 2.5f);
    bButton.layer.shadowRadius = 5.0f;
    bButton.layer.shadowOpacity = 0.35f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bButton.bounds cornerRadius:(3*fsize/4)];
    bButton.layer.shadowPath = [path CGPath];
}


- (void)addBubbleButtonsWithInterval:(CGFloat)ftime animated:(BOOL)animated
{
    // Make sure there are buttons to animate
    // Take the first button in the array, animate alpha to 1
    // Remove button from array
    // Recur. Lather, rinse, repeat until all are buttons are on screen
    
    if (self.bubbleButtonArray.count > 0) {
        UIButton *button = [self.bubbleButtonArray objectAtIndex:0];
        if (animated) {
            [UIView animateWithDuration:ftime animations:^{
                button.alpha = 1;
            } completion:^(BOOL fin){
                if (self.bubbleButtonArray.count > 0) {
                    [self.bubbleButtonArray removeObjectAtIndex:0];
                    [self addBubbleButtonsWithInterval:ftime animated:animated];
                }
            }];
        }else{
            button.alpha = 1;
            [self.bubbleButtonArray removeObjectAtIndex:0];
            [self addBubbleButtonsWithInterval:ftime animated:animated];
        }
    }
}

- (void)removeBubbleButtonsWithInterval:(CGFloat)ftime animated:(BOOL)animated
{
    // Make sure there are buttons on screen to animate
    // Take the last button on screen, animate alpha to 0
    // Remove button from superview
    // Recur. Lather, rinse, repeat until all buttons are off screen
    
    if (self.subviews.count > 0){
        UIButton *button = [self.subviews objectAtIndex:self.subviews.count - 1];
        if (animated) {
            [UIView animateWithDuration:ftime animations:^{
                button.alpha = 0;
            } completion:^(BOOL fin){
                if (self.bubbleButtonArray.count > 0) {
                    [[self.subviews objectAtIndex:self.subviews.count - 1] removeFromSuperview];
                    [self removeBubbleButtonsWithInterval:ftime animated:animated];
                }
            }];
        }else{
            button.alpha = 0;
            [[self.subviews objectAtIndex:self.subviews.count - 1] removeFromSuperview];
            [self removeBubbleButtonsWithInterval:ftime animated:animated];
        }
    }
}

- (void)clickedBubbleButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(horizontalButtonsView:didClickBubbleButton:atIndex:)]) {
        [self.delegate horizontalButtonsView:self didClickBubbleButton:button atIndex:button.tag];
    }
}

- (void)resizeToFitSubviews
{
    float w = 0;
    float h = 0;
    
    for (UIView *v in [self subviews]) {
        float fw = v.frame.origin.x + v.frame.size.width;
        float fh = v.frame.origin.y + v.frame.size.height;
        w = MAX(fw, w);
        h = MAX(fh, h);
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, w, h)];
}

@end
