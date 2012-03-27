//
//  Edge.m
//  objcvoronoi
//
//  Created by Clay Heaton on 3/26/12.
//  Copyright (c) 2012 The Perihelion Group. All rights reserved.
//

#import "Edge.h"
#import "Site.h"
#import "Vertex.h"
#import "Halfedge.h"

@implementation Edge
@synthesize lSite, rSite, va, vb;

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

@end