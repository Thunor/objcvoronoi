//
//  ClayPathMaker.m
//  objcvoronoi
//


#import "ClayPathMaker.h"
#import "Edge.h"
#import "Vertex.h"

@interface ClayPathMaker()

@property(strong, nonatomic) NSMutableArray *solution;
@property(strong, nonatomic) NSMutableArray *freshEdges;
@property(strong, nonatomic) NSMutableDictionary *vertices;
@property(strong, nonatomic) NSMutableArray *pathNodes;
@property(nonatomic) int pathsToCalculate;
@property(nonatomic) BOOL workingOnFirstPath;
@property(nonatomic) BOOL workingOnLastPath;

@end

@implementation ClayPathMaker

- (id)initWithEdges:(NSMutableArray *)voronoiEdges nodesForPath:(NSMutableArray *)pointsArray andBounds:(NSRect)bbox
{
    self = [super init];
    if (self) {
        [self setEdges:voronoiEdges];
        [self setTheBounds:bbox];
        
        _vertices  = [[NSMutableDictionary alloc] init];
        _pathNodes = [[NSMutableArray alloc] init];
        _freshEdges  = [[NSMutableArray alloc] init];
        _workingOnFirstPath = YES;
        _workingOnLastPath  = NO;
        
        NSAssert([pointsArray count] > 1, @"You must have 2 or more points in the pointsArray.");
        
        _pathsToCalculate = (int)[pointsArray count] - 1;
        [self setPoints:pointsArray];
        
        [self calculate];
    }
    return self;
}

- (void)calculate
{
    [self prepareData];
    
    int pathNum = 0;
    
    if (self.pathsToCalculate == 1) {
        self.workingOnFirstPath = YES;
        self.workingOnLastPath = YES;
    }
    
    while (pathNum < self.pathsToCalculate) {
        [self setStartAndEndForPathNum:pathNum];
        [self pathByClay];
        pathNum++;
        self.workingOnFirstPath = NO;
        
        if (pathNum == self.pathsToCalculate - 1) {
            self.workingOnLastPath = YES;
        }
        
    }
}

- (void)setStartAndEndForPathNum:(int)pathNum
{
    [self setStartPoint:[[self.points objectAtIndex:pathNum] pointValue]];
    [self setEndPoint:[[self.points objectAtIndex:pathNum + 1] pointValue]];
    
    // Find the closest vertex to the start point and make it the start vertex
    float closestStartDist = INFINITY;
    float closestEndDist   = INFINITY;
    NSString *closestStartKey, *closestEndKey;
    
    /* Iterate through the vertices in the dictionary.
     Compare the distances from each to the start and end points.
     Set the closest to be the start and end vertices.
     */
    
    for (NSValue *key in [self.vertices allKeys]) {
        Vertex *v = [self.vertices objectForKey:key];
        
        if (![self boundingBoxSharesEdgeWithVertex:v]) {
            
            // For my purposes -- looking for a vertex that isn't on the edge of the bounding box...
            
            float stDist = [self distanceFromPoint:self.startPoint toVertex:v];
            float edDist = [self distanceFromPoint:self.endPoint   toVertex:v];
            
            if (stDist < closestStartDist) {
                closestStartDist = stDist;
                closestStartKey  = [v uniqueID];
            }
            
            if (edDist < closestEndDist) {
                closestEndDist = edDist;
                closestEndKey  = [v uniqueID];
            }
        }
    }
    
    [self setStartVertex:[self.vertices objectForKey:closestStartKey]];
    [self setEndVertex:[self.vertices objectForKey:closestEndKey]];
}

- (void)pathByClay
{
    
    [[self endVertex] setTarget:YES];
    
    for (NSValue *key in self.vertices) {
        Vertex *v = [self.vertices objectForKey:key];
        [v setDistance:[v distanceToVertex:self.endVertex]];
    }
    
    [[self startVertex] setDistance:1];
    
    Vertex *currentVertex = [self startVertex];
    Vertex *nextVertex;
    Vertex *reserveVertex; // To be used in case we get stuck
    
    NSMutableDictionary *unvisitedSet = [[NSMutableDictionary alloc] initWithDictionary:self.vertices];
    [unvisitedSet removeObjectForKey:[currentVertex uniqueID]];
    
    int nilLoops = 0;
    
    while (![currentVertex target]) {
        float shortestDistance = INFINITY;
        int numkeys = (int)[[currentVertex neighborKeys] count];
        int numnilkeys = 0;

        for (NSString *key in [currentVertex neighborKeys]) {
            Vertex *evalVertex = [unvisitedSet objectForKey:key];

            if (evalVertex == nil) {
                numnilkeys += 1;
            }
            if ([evalVertex target]) {
                // Found the target

                [evalVertex setPreviousVertex:currentVertex];
                nextVertex = evalVertex;
                currentVertex = nextVertex;
                break;
            }
            
            if (evalVertex != nil && [evalVertex distance] < shortestDistance) {

                shortestDistance = [evalVertex distance];
                reserveVertex = [currentVertex previousVertex];
                nextVertex = evalVertex;
                [nextVertex setPreviousVertex:currentVertex];
            }
        }
        
        // Condition to break out if all of the remaining keys to evaluate are null
        if (numkeys == numnilkeys) {
            nilLoops ++;
            // NSLog(@"  broke out because of nil keys.");
            // NSLog(@"  %lu objects remain in unvisitedSet.", [unvisitedSet count]);
            nextVertex = reserveVertex;
            [nextVertex setPreviousVertex:[reserveVertex previousVertex]];
            
            // We know the current vertex won't work for pathfinding
            [unvisitedSet removeObjectForKey:[currentVertex uniqueID]];
        }
        
        if (nilLoops > 3) {
            nilLoops = 0;
            // We're stuck.
            nextVertex = [reserveVertex previousVertex];
            [unvisitedSet removeObjectForKey:[reserveVertex uniqueID]];
            reserveVertex = nextVertex;
        }
        
        // We've iterated through all neighbors
        currentVertex = nextVertex;
        [unvisitedSet removeObjectForKey:[currentVertex uniqueID]];
    }
    
    // Now iterate through them backwards to build the path
    // currentVertex should be the target now
    
    NSMutableArray *tempPathNodes = [[NSMutableArray alloc] init];
    
    [tempPathNodes addObject:currentVertex];
    while (currentVertex != nil) {
        if ([currentVertex previousVertex] != nil) {
            [tempPathNodes insertObject:[currentVertex previousVertex] atIndex:0];
        }
        currentVertex = [currentVertex previousVertex];
    }
    
    if (self.workingOnFirstPath) {
        Vertex *pathStart = [[Vertex alloc] initWithCoord:[self startPoint]];
        [tempPathNodes insertObject:pathStart atIndex:0];
    }
    
    if (self.workingOnLastPath) {
        Vertex *pathEnd   = [[Vertex alloc] initWithCoord:[self endPoint]];
        [tempPathNodes addObject:pathEnd];
    }
    
    // Append the vertices from this section of the path to the pathNodes array.
    [self.pathNodes addObjectsFromArray:tempPathNodes];
    
    [tempPathNodes removeAllObjects];
    
    // Reset the vertices
    for (NSValue *key in self.vertices) {
        Vertex *v = [self.vertices objectForKey:key];
        [v setTarget:NO];
        [v setDistance:INFINITY];
        [v setPreviousVertex:nil];
    }
    
    // Should be done with this path.
    
}

// Checks whether two vertices match by position
// Since more than one vertex can have the same spot
// If they match, then we return the matching one

- (Vertex *)vertexMatchingByPosition:(Vertex *)v
{
    float incomingX = [v x];
    float incomingY = [v y];
    
    for (NSValue *key in [self.vertices allKeys]) {
        Vertex *existing = [self.vertices objectForKey:key];
        float existingX = [existing x];
        float existingY = [existing y];
        if ([ClayPathMaker equalWithEpsilonA:existingX andB:incomingX]) {
            if ([ClayPathMaker equalWithEpsilonA:existingY andB:incomingY]) {
                return existing;
            }
        }
    }
    return nil;
}

- (void)prepareData
{
    
    // Initialize a vertex
    // Check whether its key is in the dictionary
    // If it isn't, add the vertex to the dictionary
    // Add the edge to the vertex.
    // If it is, then just add the edge to dictionary version of the vertex
    
    for (Edge *e in self.edges) {
        // For each edge, we want to create a new edge with the appropriate 
        // vertices and store it with each vertex.
        
        // Remove edges connected to the bounding box
        // The vertices of the existing edge
        Vertex *va = [e va];
        Vertex *vb = [e vb];
        
        if ([self boundingBoxSharesEdgeWithVertex:va] ||[self boundingBoxSharesEdgeWithVertex:vb]) {
            continue;
        }
        
        // Create the new edge
        Edge *f = [[Edge alloc] initWithLSite:[e lSite] andRSite:[e rSite]];
        
        // There are three goals here:
        // 1. Idendify the unique vertices (remove duplicates)
        // 2. Store the unique vertices with the new edges
        // 3. Store the new edges with the unique vertices;
        
        
        
        // Check for existing by uniqueID
        Vertex *existingByKey = [self.vertices objectForKey:[va uniqueID]];
        if (!existingByKey) {
            
            // Check whether it's existing by position and return the matching existing one
            Vertex *existingByPosition = [self vertexMatchingByPosition:va];
            
            if (!existingByPosition) {
                // it's not existing either by position or key, so we add this vertex
                // to the dictionary of vertices and we assign it as the va vertex for the
                // new edge and add the new edge to its 'edges' array
                
                [self.vertices setObject:va forKey:[va uniqueID]];
                [f setVa:va];
                [va addEdge:f];
            } else {
                
                // It does exist by position, so we retrieved the existing vertex
                // and now we'll assign the existing vertex as the va vertex of the new edge
                // and add the new edge to the existing vertex's edge array
                [f setVa:existingByPosition];
                [existingByPosition addEdge:f];
            }
        } else {
            // It exists by key, so we retrieve the existing vertex
            // and assign it as the va vertex for the new edge and then add the new edge
            // to the 'edges' array of the vertex.
            [f setVa:existingByKey];
            [existingByKey addEdge:f];
        }
        
        
        // Check for existing by uniqueID
        existingByKey = [self.vertices objectForKey:[vb uniqueID]];
        if (!existingByKey) {
            
            // Check whether it's existing by position and return the matching existing one
            Vertex *existingByPosition = [self vertexMatchingByPosition:vb];
            
            if (!existingByPosition) {
                // It's not existing either by position or key, so we add this vertex
                // to the dictionary of vertices and we assign it as the vb vertex for the
                // new edge and add the new edge to its 'edges' array
                
                [self.vertices setObject:vb forKey:[vb uniqueID]];
                [f setVb:vb];
                [vb addEdge:f];
            } else {
                // It does exist by position, so we retrieved the existing vertex
                // and now we'll assign the existing vertex as the vb vertex of the new edge
                // and add the new edge to the existing vertex's edge array
                [f setVb:existingByPosition];
                [existingByPosition addEdge:f];
            }
        } else {
            // It exists by key, so we retrieve the existing vertex
            // and assign it as the vb vertex for the new edge and then add the new edge
            // to the 'edges' array of the vertex.
            [f setVb:existingByKey];
            [existingByKey addEdge:f];
        }
        
        // Add the new edge to the freshEdges array
        [self.freshEdges addObject:f];

    }
    
    // Remove vertices on the edge because I don't want to use them
    for (NSValue *key in [self.vertices allKeys]) {
        Vertex *v = [self.vertices objectForKey:key];
        if ([self boundingBoxSharesEdgeWithVertex:v]) {
            [v setOnBoundingBox:YES];
        }
    }
    
    
    // Calculate the neighbor vertices for each vertex that isn't on the edge
    for (NSValue *key in self.vertices) {
        Vertex *v = [self.vertices objectForKey:key];
        [v calcNeighborKeys];

    }
}


// Let's return an array of NSPoints as values
// Don't forget to include the start point and end point
- (NSMutableArray *)getPathNodes
{
    // Create an array without duplicate vertices
    NSMutableArray *cleanArray = [[NSMutableArray alloc] init];
    
    for (Vertex *v in self.pathNodes) {
        if (![cleanArray containsObject:v]) {
            [cleanArray addObject:v];
        }
    }
    
    // Convert the vertices into point.
    NSMutableArray *finalPath = [[NSMutableArray alloc] init];
    
    // Iterate through the pathNodes and add them
    for (Vertex *v in cleanArray) {
        [finalPath addObject:[NSValue valueWithPoint:[v coord]]];
    }
    
    return finalPath;
}

+ (BOOL)equalWithEpsilonA:(float)a andB:(float)b
{
    return fabsf(a - b) < 0.00005;
}

/* For my purposes, I don't want the vertex located as closest to the start/end
 point to be on the edge of the bounding box, so this checks whether it is
 */

- (BOOL)boundingBoxSharesEdgeWithVertex:(Vertex *)dv
{
    float boundsMinX = self.theBounds.origin.x;
    float boundsMaxX = self.theBounds.origin.x + self.theBounds.size.width;
    float boundsMinY = self.theBounds.origin.y;
    float boundsMaxY = self.theBounds.origin.y + self.theBounds.size.height;
    
    float dvx = [dv x];
    float dvy = [dv y];
    
    if ([ClayPathMaker equalWithEpsilonA:boundsMinX andB:dvx]) {
        return YES;
    }
    if ([ClayPathMaker equalWithEpsilonA:boundsMaxX andB:dvx]) {
        return YES;
    }
    if ([ClayPathMaker equalWithEpsilonA:boundsMinY andB:dvy]) {
        return YES;
    }
    if ([ClayPathMaker equalWithEpsilonA:boundsMaxY andB:dvy]) {
        return YES;
    }
    
    return NO;
}

- (float)distanceFromPoint:(NSPoint)pt toVertex:(Vertex *)dv
{
    float x1 = pt.x;
    float y1 = pt.y;
    float x2 = [dv x];
    float y2 = [dv y];
    
    float a = fabsf(x2 - x1);
    float b = fabsf(y2 - y1);
    
    float dist = sqrtf(a*a + b*b);
    return dist;
}

- (NSMutableArray *)solution
{
    return self.solution;
}
@end
