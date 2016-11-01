//
//  ClayPathMaker.h
//  objcvoronoi
//


#import <Foundation/Foundation.h>

@class Edge;
@class Vertex;

@interface ClayPathMaker : NSObject

@property (copy, readwrite) NSMutableArray *edges;
@property (retain, readwrite) NSMutableArray *points;
@property (assign, readwrite) NSPoint startPoint;
@property (assign, readwrite) NSPoint endPoint;
@property (retain, readwrite) Vertex *startVertex;
@property (retain, readwrite) Vertex *endVertex;
@property (assign, readwrite) NSRect theBounds;

+ (BOOL)equalWithEpsilonA:(float)a andB:(float)b;

- (id)initWithEdges:(NSMutableArray *)voronoiEdges nodesForPath:(NSMutableArray *)pointsArray andBounds:(NSRect)bbox;
- (NSMutableArray *)solution;
- (void)calculate;
- (float)distanceFromPoint:(NSPoint)pt toVertex:(Vertex *)dv;
- (BOOL)boundingBoxSharesEdgeWithVertex:(Vertex *)dv;
- (void)prepareData;
- (void)setStartAndEndForPathNum:(int)pathNum;
- (void)pathByClay;
- (NSMutableArray *)getPathNodes;
- (Vertex *)vertexMatchingByPosition:(Vertex *)v;

@end


