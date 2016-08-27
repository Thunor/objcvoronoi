//
//  VoronoiView.h
//  objcvoronoi
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface VoronoiView : NSView

@property (retain, readwrite) NSMutableArray *sites;
@property (retain, readwrite) NSMutableArray *cells;
@property (retain, readwrite) NSMutableArray *dijkstraPathPoints;

@end
