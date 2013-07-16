#import "SmoothedBIView.h"

@implementation SmoothedBIView
{
    UIBezierPath *path;
    UIImage *incrementalImage;
    CGPoint pointsArray[5];
    uint counter;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO];
        path = [UIBezierPath bezierPath];
        [path setLineWidth:2.0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMultipleTouchEnabled:NO];
        path = [UIBezierPath bezierPath];
        [path setLineWidth:2.0];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [incrementalImage drawInRect:rect];
    [path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    counter = 0;
    pointsArray[0] = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    counter++;
    pointsArray[counter] = [[touches anyObject] locationInView:self];
    if (counter == 4) 
    {
        pointsArray[3] = CGPointMake((pointsArray[2].x + pointsArray[4].x)/2.0,
                                     (pointsArray[2].y + pointsArray[4].y)/2.0);
        [path moveToPoint:pointsArray[0]];
        [path addCurveToPoint:pointsArray[3]
                controlPoint1:pointsArray[1]
                controlPoint2:pointsArray[2]];
        [self setNeedsDisplay];
        pointsArray[0] = pointsArray[3]; 
        pointsArray[1] = pointsArray[4]; 
        counter = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self drawBitmap];
    [self setNeedsDisplay];
    [path removeAllPoints];
    counter = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    if (!incrementalImage)
    {
      [self eraseAll];
    }
    [incrementalImage drawAtPoint:CGPointZero];
    [[UIColor blackColor] setStroke];
    [path stroke];
    incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)eraseAll {
  UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
  UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
  [[UIColor whiteColor] setFill];
  [rectpath fill];
  incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
}

@end