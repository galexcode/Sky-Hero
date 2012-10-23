//
//  CCAnimation+Helper.h
//  Drop
//
//  Created by Aaron on 12-10-11.
//
//

#import "CCAnimation.h"

@interface CCAnimation (Helper)
+(CCAnimation*) animationWithFile:(NSString*)name frameCount:(int)frameCount delay:(float)delay;
+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount delay:(float)delay;
@end
