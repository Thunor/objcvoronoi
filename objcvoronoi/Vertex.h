//
//  Vertex.h
//  objcvoronoi
//

// Most variations from Site are here to
// support working with Dijkstra's algorithm
// and are not necessary for Voronoi generation

#import "Site.h"

@class Edge;

@interface Vertex : Site

@property (assign, readwrite) BOOL visited;
@property (assign, readwrite) BOOL target;
@property (assign, readwrite) BOOL onBoundingBox;
@property (assign, readwrite) float distance;
@property (retain, readwrite) Vertex *previousVertex;
@property (strong, readwrite, nonatomic) NSMutableArray *neighborKeys;

- (id)initWithCoord:(NSPoint)tempCoord;
- (id)initWithValue:(NSValue *)valueWithCoord;

- (NSString *)uniqueID;
- (int)uniqueIDAsInt;

- (float)distanceToVertex:(Vertex *)v;

- (void)addEdge:(Edge *)e;

- (void)calcNeighborKeys;

@end
