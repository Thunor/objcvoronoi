//
//  Site.h
//  objcvoronoi
//

#import <Foundation/Foundation.h>

@interface Site : NSObject

@property (assign, readwrite) int voronoiId;
@property (readwrite, nonatomic) NSPoint coord;

- (id)initWithCoord:(NSPoint)tempCoord;
- (id)initWithValue:(NSValue *)valueWithCoord;

- (void)setCoordAsValue:(NSValue *)valueWithCoord;
- (NSValue *)coordAsValue;

- (void)setX:(float)tempX;
- (float)x;

- (void)setY:(float)tempY;
- (float)y;

+ (NSMutableArray*)sortSites:(NSMutableArray *)siteArray;
- (NSComparisonResult)compare:(Site *)s;

@end
