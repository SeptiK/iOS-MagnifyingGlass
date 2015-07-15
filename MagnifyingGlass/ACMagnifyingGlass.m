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

@synthesize viewToMagnify, touchPoint, touchPointOffset, scale, scaleAtTouchPoint;

- (id)init {
    self = [self initWithFrame:CGRectMake(0, 0, kACMagnifyingGlassDefaultRadius*2, kACMagnifyingGlassDefaultRadius*2)];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 3;
		self.layer.cornerRadius = frame.size.width / 2;
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
	self.layer.cornerRadius = f.size.width / 2;
}

- (void)setTouchPoint:(CGPoint)point {
	touchPoint = point;
	[self updateCenter];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, self.frame.size.width/2, self.frame.size.height/2 );
	CGContextScaleCTM(context, scale, scale);
	CGContextTranslateCTM(context, -touchPoint.x, -touchPoint.y + (self.scaleAtTouchPoint? 0 : self.bounds.size.height/2));
	[self.viewToMagnify.layer renderInContext:context];
}

#pragma mark - Helper methods

- (void)updateCenter {
	CGPoint point = self.touchPoint;
	CGRect boundingBox = self.superview.bounds;
	CGFloat hitRadius = CGRectGetWidth(self.bounds) / 4;

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
