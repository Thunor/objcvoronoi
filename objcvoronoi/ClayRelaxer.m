//
//  ClayRelaxer.m
//  objcvoronoi
//
//  Created by Clay Heaton on 3/30/12.
//  Copyright (c) 2012 The Perihelion Group. All rights reserved.
//

#import "ClayRelaxer.h"
#import "Site.h"
#import "Vertex.h"
#import "Cell.h"
#import "Edge.h"
#import "Halfedge.h"
#import "Vertex.h"

@interface ClayRelaxer()

@property(strong, nonatomic) NSMutableArray *cells;

@end

@implementation ClayRelaxer


- (id)initWithCells:(NSMutableArray *)cellArray
{
    self = [super init];
    if (self) {
        self.cells = [[NSMutableArray alloc] initWithArray:cellArray];
        self.freshSites = [[NSMutableArray alloc] init];
        
    }
    return self;
}

// Return an NSMutableArray of NSValues that encode NSPoints that
// can be used to regenerate the Voronoi diagram
+ (NSMutableArray *)relaxSitesInCells:(NSMutableArray *)cellArray
{
    ClayRelaxer *cr = [[ClayRelaxer alloc] initWithCells:cellArray];
    [cr processCells];
    return [cr freshSites];
    
}

- (void)processCells
{
    //NSLog(@"Processing Cells...");
    // Iterate through each cell, process its sites, and then 
    // put the new site into the freshSites array.
    for (Cell *c in self.cells) {
        
        // Put the point from the cell into this array, which we'll process
        NSMutableArray *cellPoints = [[NSMutableArray alloc] init];
        
        for (Halfedge *he in [c halfedges]) {
            // Get the start point from each halfedge
            // and thereby avoid getting duplicates
            // (vs. getting both points).
            Vertex *start = [he getStartpoint];
            [cellPoints addObject:[NSValue valueWithPoint:[start coord]]];
        }
        
        float newX = 0;
        float newY = 0;
        float countPoints = 0;
        
        for (NSValue *v in cellPoints) {
            newX += [v pointValue].x;
            newY += [v pointValue].y;
            countPoints += 1;
        }
        
        newX = newX / countPoints;
        newY = newY / countPoints;
        
        [self.freshSites addObject:[NSValue valueWithPoint:NSMakePoint(newX, newY)]];
    }
    //NSLog(@"...completed processing cells.");
}
@end
