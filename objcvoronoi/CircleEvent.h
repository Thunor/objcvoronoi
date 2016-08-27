//
//  CircleEvent.h
//  objcvoronoi
//

#import <Foundation/Foundation.h>

@class Beachsection;
@class Site;

@interface CircleEvent : NSObject

@property (retain, readwrite) CircleEvent *rbNext;
@property (retain, readwrite) CircleEvent *rbPrevious;
@property (retain, readwrite) CircleEvent *rbParent;
@property (retain, readwrite) CircleEvent *rbRight;
@property (retain, readwrite) CircleEvent *rbLeft;
@property (assign, readwrite) BOOL rbRed;


@property (assign, readwrite) NSPoint coord;

@property (retain, readwrite) Beachsection *arc;

// TODO: Look for uses of circle event coord and determine whether it should be site.
@property (retain, readwrite) Site *site;

@property (assign, readwrite) float ycenter;

- (void)setCoord:(NSPoint)tempCoord;
- (NSPoint)coord;

- (void)setCoordAsValue:(NSValue *)valueWithCoord;
- (NSValue *)coordAsValue;

- (void)setX:(float)tempX;
- (float)x;

- (void)setY:(float)tempY;
- (float)y;

@end
