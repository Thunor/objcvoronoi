//
//  Cell.h
//  objcvoronoi
//

#import <Foundation/Foundation.h>

@class Site;
@class Halfedge;

@interface Cell : NSObject

@property (retain, readwrite) Site *site;
@property (strong, nonatomic, readwrite) NSMutableArray *halfedges;

- (id)initWithSite:(Site *)s;
- (int)prepare;
- (void)addHalfedgeToArray:(Halfedge *)he;

@end
