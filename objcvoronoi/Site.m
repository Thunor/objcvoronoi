//
//  Site.m
//  objcvoronoi
//

#import "Site.h"

@implementation Site

- (NSString *)description
{
    return [NSString stringWithFormat:@"(coord: %@, voronoiId: %i)", NSStringFromPoint(self.coord), self.voronoiId];
}

- (id)initWithCoord:(NSPoint)tempCoord
{
    self = [super init];
    if (self) {
        [self setCoord:tempCoord];
    }
    return self;
}

- (id)initWithValue:(NSValue *)valueWithCoord
{
    self = [super init];
    if (self) {
        [self setCoord:[valueWithCoord pointValue]];
    }
    return self;
}

- (id)init
{
    return [self initWithCoord:NSZeroPoint];
}

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

+ (NSMutableArray*)sortSites:(NSMutableArray *)siteArray
{
    NSMutableArray *sorted = [siteArray sortedArrayUsingSelector:@selector(compare:)].mutableCopy;
    return sorted;
}

- (NSComparisonResult)compare:(Site *)s
{
    CGFloat ax = self.coord.x;
    CGFloat ay = self.coord.y;
    CGFloat bx = s.coord.x;
    CGFloat by = s.coord.y;
    
    if (ay < by) return NSOrderedDescending;
    if (ay > by) return NSOrderedAscending;
    if (ax < bx) return NSOrderedDescending;
    if (ax > bx) return NSOrderedAscending;
    
    return NSOrderedSame;
}

@end
