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

+ (void)sortSites:(NSMutableArray *)siteArray
{
    [siteArray sortUsingSelector:@selector(compare:)];
}

// TODO: Check that this is returning in the proper order;
- (NSComparisonResult)compare:(Site *)s
{
    if (self.y < s.y) return NSOrderedDescending;
    if (self.y > s.y) return NSOrderedAscending;
    if (self.x < s.x) return NSOrderedDescending;
    if (self.x > s.x) return NSOrderedAscending;
    
    return NSOrderedSame;
}

@end
