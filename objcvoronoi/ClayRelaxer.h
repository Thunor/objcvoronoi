//
//  ClayRelaxer.h
//  objcvoronoi
//
//  Created by Clay Heaton on 3/30/12.
//  Copyright (c) 2012 The Perihelion Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cell;
@class Edge;
@class Halfedge;
@class Vertex;

@interface ClayRelaxer : NSObject


@property(strong, nonatomic) NSMutableArray *freshSites;

// Call this to use the relaxer.
+ (NSMutableArray *)relaxSitesInCells:(NSMutableArray *)cellArray;

- (id)initWithCells:(NSMutableArray *)cellArray;
- (void)processCells;
//- (NSMutableArray *)Sites;

@end
