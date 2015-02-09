//
//  BBView.h
//  BubbleButtonView
//
//  Created by Benjamin Gordon on 1/8/13.
//  Copyright (c) 2013 Benjamin Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KMHorizontalButtonsView;

@protocol KMHorizontalButtonsViewDelegate <NSObject>

- (void)horizontalButtonsView:(KMHorizontalButtonsView *)horizontalButtonsView didClickBubbleButton:(UIButton *)button atIndex:(NSInteger)index;

@end

@interface KMHorizontalButtonsView : UIView

@property (weak) id <KMHorizontalButtonsViewDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *bubbleButtonArray;

- (void)fillBubbleViewWithButtons:(NSArray *)strings bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor fontName:(NSString *)fontName fontSize:(CGFloat)fsize applyShadow:(BOOL)applyShadow animated:(BOOL)animated resizeToFitSubviews:(BOOL)resizeToFitSubviews;
- (void)addBubbleButtonsWithInterval:(CGFloat)ftime animated:(BOOL)animated;
- (void)removeBubbleButtonsWithInterval:(CGFloat)ftime animated:(BOOL)animated;
- (void)clickedBubbleButton:(UIButton *)bubble;
- (void)resizeToFitSubviews;

@end
