//
//  CCAnimation+Helper.m
//  Drop
//
//  Created by Aaron on 12-10-11.
//
//
#import "cocos2d.h"
#import "CCAnimation+Helper.h"

@implementation CCAnimation (Helper)
+(CCAnimation*) animationWithFile:(NSString *)name frameCount:(int)frameCount delay:(float)delay
{
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    for (int i=0; i<frameCount; i++) {
        NSString* file = [NSString stringWithFormat:@"%@%i.png",name,i];
        CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];
        
		// Assuming that image file animations always use the whole image for each animation frame.
		CGSize texSize = texture.contentSize;
		CGRect texRect = CGRectMake(0, 0, texSize.width, texSize.height);
		CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:texRect];
		
		[frames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}
+(CCAnimation*) animationWithFrame:(NSString *)frame frameCount:(int)frameCount delay:(float)delay
{
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    for (int i=0; i<frameCount; i++) {
        NSString* file = [NSString stringWithFormat:@"%@%i.png",frame,i];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
        [frames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}
@end
