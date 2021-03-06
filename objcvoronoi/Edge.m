//
//  Edge.m
//  objcvoronoi
//

#import "Edge.h"
#import "Site.h"
#import "Vertex.h"
#import "Halfedge.h"

@implementation Edge

- (id)initWithLSite:(Site *)theLSite andRSite:(Site *)theRSite
{
    self = [super init];
    if (self) {
        [self setLSite:theLSite];
        [self setRSite:theRSite];
        [self setVa:nil];
        [self setVb:nil];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ | va: %@, vb: %@",[self.va uniqueID], [self.vb uniqueID], self.va, self.vb];
}

@end
