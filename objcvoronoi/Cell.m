//
//  Cell.m
//  objcvoronoi
//

#import "Cell.h"
#import "Site.h"
#import "Halfedge.h"
#import "Edge.h"

@interface Cell()

@end

@implementation Cell
@synthesize site;

- (NSString *)description
{
    NSString *d = [NSString stringWithFormat:@"Cell | site: %@, halfedges: %@", site, self.halfedges];
    return d;
}

- (id)initWithSite:(Site *)s
{
    self = [super init];
    if (self) {
        [self setSite:s];
        self.halfedges = [[NSMutableArray alloc] init];
    }
    return self;
}

- (int)prepare
{
    int iHalfedge = (int)[self.halfedges count];
    Edge *thisEdge;
    // get rid of unused halfedges
    while (iHalfedge--) {
        Halfedge *he = [self.halfedges objectAtIndex:iHalfedge];
        thisEdge = [he edge];
        if (![thisEdge vb] || ![thisEdge va]) {
            [self.halfedges removeObjectAtIndex:iHalfedge]; // Double-check this in production vs. js
            // halfedges.splice(iHalfedge,1);
        }
    }
    [Halfedge sortArrayOfHalfedges:self.halfedges];          // Possible problem point...
    
    return (int)[self.halfedges count];
}

- (void)addHalfedgeToArray:(Halfedge *)he
{
    [self.halfedges addObject:he];
}

@end
