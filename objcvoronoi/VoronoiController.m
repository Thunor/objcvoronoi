//
//  VoronoiController.m
//  objcvoronoi
//

#import "VoronoiController.h"
#import "Voronoi.h"
#import "VoronoiResult.h"
#import "VoronoiView.h"
#import "Site.h"
#import "Cell.h"
#import "ClayPathMaker.h"
#import "ClayRelaxer.h"

@interface VoronoiController()

@property(strong, nonatomic) Voronoi *voronoi;
@property(strong, nonatomic) VoronoiResult *activeResult;
@property(weak, nonatomic) IBOutlet VoronoiView *voronoiview;
@property(weak, nonatomic) IBOutlet NSTextField *numSitesEntry;
@property(weak, nonatomic) IBOutlet NSTextField *marginEntry;
@property(weak, nonatomic) IBOutlet NSButton *drawButton;
@property(weak, nonatomic) IBOutlet NSButton *relaxButton;

@property(strong, nonatomic) NSMutableArray *randomPoints;

@end


@implementation VoronoiController

- (id)init {
    self = [super init];
    if (self) {
        _randomPoints = [[NSMutableArray alloc] init];
    }
    return self;
}

- (IBAction)relaxWithLloyd:(id)sender {
    NSMutableArray *freshSites = [ClayRelaxer relaxSitesInCells:[self.activeResult cells]];
    [self createVoronoiWithFreshSites:freshSites];
}

- (IBAction)createVoronoi:(id)sender {
    [self.randomPoints removeAllObjects];
    self.activeResult = nil;
    
    int numSites = [self.numSitesEntry intValue];
    int margin   = [self.marginEntry   intValue];
    
    // Send in sites as NSPoints that have been converted to NSValue
    
    self.xMax = [self.voronoiview bounds].size.width;
    self.yMax = [self.voronoiview bounds].size.height;
    
    for (int i = 0; i < numSites; i++) {
        float x = margin + (arc4random() % ((int)self.xMax - margin*2));
        float y = margin + (arc4random() % ((int)self.yMax - margin*2));
        NSValue *v = [NSValue valueWithPoint:NSMakePoint(x, y)];
        [self.randomPoints addObject:v];
    }
    
    [self calculateVoronoi];
}

- (void)createVoronoiWithFreshSites:(NSMutableArray *)freshSites {
    // Clear the old
    [self.randomPoints removeAllObjects];
    self.randomPoints = nil;
    self.activeResult = nil;
    
    // Set the new points
    self.randomPoints = freshSites;
    
    // Calculate the diagram
    [self calculateVoronoi];
}

- (void)calculateVoronoi {
    
    self.voronoi = [[Voronoi alloc] init];
    self.activeResult = [self.voronoi computeWithSites:self.randomPoints andBoundingBox:[self.voronoiview bounds]];
    
    NSMutableArray *sitesFromCells = [[NSMutableArray alloc] init];
    
    for (Cell *c in [self.activeResult cells]) {
        Site *s = [c site];
        [sitesFromCells addObject:[s coordAsValue]];
    }
    
    [self.voronoiview setSites:sitesFromCells];
    [self.voronoiview setCells:[self.activeResult cells]];
    
    if ([self.randomPoints count] > 4) {
        
        NSValue *start = [NSValue valueWithPoint:NSMakePoint(0, self.yMax * 0.5)];
        NSValue *end   = [NSValue valueWithPoint:NSMakePoint(self.xMax, self.yMax * 0.5)];
        NSValue *midPoint = [NSValue valueWithPoint:NSMakePoint(self.xMax * 0.33, 0)];
        NSValue *midPoint2 = [NSValue valueWithPoint:NSMakePoint(self.xMax * 0.66, self.yMax)];
        
        NSMutableArray *pathNodes = [[NSMutableArray alloc] init];
        [pathNodes addObject:start];
        [pathNodes addObject:midPoint];
        [pathNodes addObject:midPoint2];
        [pathNodes addObject:end];
        
        ClayPathMaker *dij = [[ClayPathMaker alloc] initWithEdges:[self.activeResult edges]
                                                       nodesForPath:pathNodes
                                                          andBounds:[self.voronoiview bounds]];
        [self.voronoiview setDijkstraPathPoints:[dij getPathNodes]];
    } else {
        [self.voronoiview setDijkstraPathPoints:nil];
    }
    
    [self.voronoiview setNeedsDisplay:YES];

    [self.relaxButton setEnabled:YES];
    
}

@end
