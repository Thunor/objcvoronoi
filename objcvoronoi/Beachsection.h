//
//  Beachsection.h
//  objcvoronoi
//

#import <Foundation/Foundation.h>

@class Site;
@class Edge;
@class CircleEvent;

@interface Beachsection : NSObject

@property (retain, readwrite)Beachsection *rbNext;
@property (retain, readwrite)Beachsection *rbPrevious;
@property (retain, readwrite)Beachsection *rbParent;
@property (retain, readwrite)Beachsection *rbRight;
@property (retain, readwrite)Beachsection *rbLeft;
@property (assign, readwrite) BOOL rbRed;
@property (retain, readwrite)Site *site;
@property (retain, readwrite)Edge *edge;
@property (retain, readwrite)CircleEvent *circleEvent;

// Use this to create Beachsections
+ (id)createBeachSectionFromJunkyard:(NSMutableArray *)junkyard withSite:(Site *)theSite;

// Init method is called by class method above if needed.
- (id)initWithSite:(Site *)theSite;

@end
