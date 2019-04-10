//
//  ACMagnifyingGlass.m
//  MagnifyingGlass
//

#import "ACMagnifyingGlass.h"
#import <QuartzCore/QuartzCore.h>


static CGFloat const kACMagnifyingGlassDefaultRadius = 40;
static CGFloat const kACMagnifyingGlassDefaultOffset = -40;
static CGFloat const kACMagnifyingGlassDefaultScale = 1.5;

@interface ACMagnifyingGlass ()
@end

@implementation ACMagnifyingGlass

@synthesize viewToMagnify, touchPoint, touchPointOffset, scale, scaleAtTouchPoint, isFixed;

- (id)init {
    self = [self initWithFrame:CGRectMake(0, 0, kACMagnifyingGlassDefaultRadius*2, kACMagnifyingGlassDefaultRadius*2)];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 3;
		self.layer.cornerRadius = CGRectGetWidth(frame) / 2;
		self.layer.masksToBounds = YES;
		self.touchPointOffset = kACMagnifyingGlassDefaultOffset;
		self.scale = kACMagnifyingGlassDefaultScale;
		self.viewToMagnify = nil;
		self.scaleAtTouchPoint = YES;
		self.wrapToSuperview = NO;
	}
	return self;
}

- (void)didMoveToSuperview {
	[super didMoveToSuperview];
	[self updateCenter];
}

- (void)setFrame:(CGRect)f {
	super.frame = f;
	self.layer.cornerRadius = CGRectGetWidth(f) / 2;
}

- (void)setTouchPoint:(CGPoint)point {
	touchPoint = point;
	[self updateCenter];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2 );
	CGContextScaleCTM(context, scale, scale);
	CGContextTranslateCTM(context, -touchPoint.x, -touchPoint.y + (self.scaleAtTouchPoint? 0 : CGRectGetHeight(self.bounds)/2));
	[self.viewToMagnify.layer renderInContext:context];
}

#pragma mark - Helper methods

- (void)updateCenter {
	CGPoint point = self.touchPoint;
	CGRect boundingBox = self.superview.bounds;
	CGFloat hitRadius = CGRectGetWidth(self.bounds) / 4;
    
    if (self.isFixed) {
        CGPoint fixedPoint = CGPointMake(self.viewToMagnify.bounds.size.width / 2, 0);
        self.center = [self.viewToMagnify convertPoint:fixedPoint toView:self.superview];
        return;
    }
    
	// try to show ourselves fully
	self.center = CGPointMake(point.x, point.y + self.touchPointOffset);
	if (self.superview && self.wrapToSuperview) {
		if (!CGRectContainsRect(boundingBox, CGRectInset(self.frame, hitRadius, hitRadius)))
			self.center = CGPointMake(point.x - self.touchPointOffset, point.y);
		if (!CGRectContainsRect(boundingBox, CGRectInset(self.frame, hitRadius, hitRadius)))
			self.center = CGPointMake(point.x + self.touchPointOffset, point.y);
		if (!CGRectContainsRect(boundingBox, CGRectInset(self.frame, hitRadius, hitRadius)))
			self.center = CGPointMake(point.x, point.y - self.touchPointOffset);
	}
    
}

@end
