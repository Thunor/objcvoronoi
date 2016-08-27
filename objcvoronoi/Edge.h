//
//  Edge.h
//  objcvoronoi
//

#import <Foundation/Foundation.h>

@class Site;
@class Vertex;
@class Halfedge;

@interface Edge : NSObject

@property (retain, readwrite) Site *lSite;
@property (retain, readwrite) Site *rSite;
@property (retain, readwrite) Vertex *va;
@property (retain, readwrite) Vertex *vb;

- (id)initWithLSite:(Site *)theLSite andRSite:(Site *)theRSite;

@end
