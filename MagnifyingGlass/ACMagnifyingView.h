//
//  ACMagnifyingView.h
//  MagnifyingGlass
//
//  Created by Arnaud Coomans on 30/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACMagnifyingGlass;

@protocol ACMagnifyingViewProtocol <NSObject>

- (BOOL)magnifyGlassShouldStartTouch;

@optional
- (void)magnifyGlassTouchStarted:(UITouch *)touch;
- (void)magnifyGlassMovedWithTouch:(UITouch *)touch;
- (void)magnifyGlassTouchEnded:(UITouch *)touch;

@end

@interface ACMagnifyingView : UIView

@property (nonatomic, strong) ACMagnifyingGlass *magnifyingGlass;
@property (nonatomic, assign) CGFloat magnifyingGlassShowDelay;
@property (nonatomic, weak) id<ACMagnifyingViewProtocol> delegate;

@end
