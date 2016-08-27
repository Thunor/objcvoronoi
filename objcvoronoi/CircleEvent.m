//
//  CircleEvent.m
//  objcvoronoi
//

#import "CircleEvent.h"
#import "Beachsection.h"
#import "Site.h"

@implementation CircleEvent

- (void)setCoordAsValue:(NSValue *)valueWithCoord
{
    self.coord = [valueWithCoord pointValue];
}

- (NSValue *)coordAsValue
{
    return [NSValue valueWithPoint:self.coord];
}

- (void)setX:(float)tempX
{
    [self setCoord:NSMakePoint(tempX, self.coord.y)];
}

- (float)x
{
    return self.coord.x;
}

- (void)setY:(float)tempY
{
    [self setCoord:NSMakePoint(self.coord.x, tempY)];
}

- (float)y
{
    return self.coord.y;
}

@end
