//
//  ACMagnifyingGlass.h
//  MagnifyingGlass
//

// doc: http://coffeeshopped.com/2010/03/a-simpler-magnifying-glass-loupe-view-for-the-iphone

#import <UIKit/UIKit.h>

@interface ACMagnifyingGlass : UIView

@property (nonatomic, strong) UIView *viewToMagnify;
@property (nonatomic, assign) CGPoint touchPoint;
@property (nonatomic, assign) CGFloat touchPointOffset;
@property (nonatomic, assign) CGFloat scale; 
@property (nonatomic, assign) BOOL scaleAtTouchPoint; 
@property (nonatomic, assign) BOOL wrapToSuperview;

@end
