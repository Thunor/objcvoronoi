//
//  VoronoiView.m
//  objcvoronoi
//

#import "VoronoiView.h"
#import "Cell.h"
#import "Halfedge.h"
#import "Edge.h"
#import "Site.h"
#import "Vertex.h"

@implementation VoronoiView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/* Can be useful for testing
 
- (BOOL)isFlipped
{
    return YES;
}
 
*/

- (void)drawRect:(NSRect)dirtyRect {
    [NSGraphicsContext saveGraphicsState];
    
    // Fill the background white
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:[self bounds]];
    
    if (self.drawPointLines) {
        [[NSColor greenColor] set];
        
        for (Cell *c in self.cells) {
            for (Halfedge *he in [c halfedges]) {
                NSPoint p1 = [[[he edge] lSite] coord];
                NSPoint p2 = [[[he edge] rSite] coord];
                
                if (!(p1.x == 0 && p1.y == 0) && !(p2.x == 0 && p2.y == 0)) {
                
                    NSBezierPath *p = [[NSBezierPath alloc] init];
                    [p setLineWidth:0.5];
                    [p moveToPoint:p1];
                    [p lineToPoint:p2];
                    [p closePath];
                    [p stroke];
                    
                    [[NSColor greenColor] setStroke];
                }
            }
        }
    }
    
    if (self.drawCells) {
        [[NSColor blackColor] set];
        
        for (Cell *c in self.cells) {
            for (Halfedge *he in [c halfedges]) {
                NSPoint p1 = [[[he edge] va] coord];
                NSPoint p2 = [[[he edge] vb] coord];
                
                NSBezierPath *p = [[NSBezierPath alloc] init];
                [p setLineWidth:2];
                [p moveToPoint:p1];
                [p lineToPoint:p2];
                [p closePath];
                [p stroke];
                
                [[NSColor blueColor] setStroke];
            }
        }
    }
    
    // Draw Dijkstra path
    if (self.drawPath) {
        [[NSColor redColor] set];
        
        NSBezierPath *dij = [[NSBezierPath alloc] init];
        [dij setLineWidth:2];
        [dij moveToPoint:[[self.dijkstraPathPoints objectAtIndex:0] pointValue]];
        
        for (int i = 1; i < [self.dijkstraPathPoints count]; i++) {
            NSPoint p = [[self.dijkstraPathPoints objectAtIndex:i] pointValue];
            [dij lineToPoint:p];
        }
        
        [dij stroke];
    }
    
    
    if (self.drawPoints) {
        [[NSColor redColor] set];
        
        for (NSValue *v in self.sites) {
            NSBezierPath *p = [[NSBezierPath alloc] init];
            [p appendBezierPathWithArcWithCenter:[v pointValue] radius:2.0 startAngle:0 endAngle:360];
            [p fill];
        }
    }
    
    [NSGraphicsContext restoreGraphicsState];
}

@end
