//
//  Vertex.m
//  objcvoronoi
//

#import "Vertex.h"
#import "Edge.h"

static int identifier = 0;

@interface Vertex()

@property(nonatomic) int UUID;
@property(strong, nonatomic) NSMutableArray *edges;

@end

@implementation Vertex

- (id)initWithCoord:(NSPoint)tempCoord
{
    self = [super initWithCoord:tempCoord];
    if (self) {
        _UUID = identifier;
        identifier++;
        _visited = NO;
        _target = NO;
        _onBoundingBox = NO;
        _distance = INFINITY;
        _edges = [[NSMutableArray alloc] init];
        _neighborKeys = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithValue:(NSValue *)valueWithCoord
{
    self = [super initWithValue:valueWithCoord];
    if (self) {
        _UUID = identifier;
        identifier++;
        [self setVisited:NO];
        [self setTarget:NO];
        [self setDistance:INFINITY];
        self.edges = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"uniqueID: %i, x: %f, y: %f",[self uniqueIDAsInt], [self x], [self y]];
}

- (NSString *)uniqueID
{
    return [NSString stringWithFormat:@"%i", self.UUID];
}

- (int)uniqueIDAsInt
{
    return self.UUID;
}

- (float)distanceToVertex:(Vertex *)v
{
    float x1 = [self coord].x;
    float y1 = [self coord].y;
    float x2 = [v    coord].x;
    float y2 = [v    coord].y;
    
    float a = fabsf(x2 - x1);
    float b = fabsf(y2 - y1);
    
    // Weight against borderbox vertices
    if ([v onBoundingBox]) {
        a = a*a;
        b = b*b;
    }
    
    return sqrtf(a*a + b*b);
}

- (void)addEdge:(Edge *)e
{
    if (![self.edges containsObject:e]) {
        [self.edges addObject:e];
    }
}

- (void)calcNeighborKeys
{
    // We know that this vertex is associated with each edge in the edges array
    // We have to figure out which vertex it is on each edge and then store the
    // uniqueID of the other vertex in 
    
    for (Edge *e in self.edges) {
        Vertex *otherVertex;
        if (self == [e va]) {
            otherVertex = [e vb];
        } else if (self == [e vb]) {
            otherVertex = [e va];
        }
        NSAssert(otherVertex != nil, @"Vertex: neighborKeys -- otherVertex is nil");
        [self.neighborKeys addObject:[otherVertex uniqueID]];
    }
}

@end
