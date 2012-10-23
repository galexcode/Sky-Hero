#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxBackground : CCNode 
{
	CCSpriteBatchNode* spriteBatch;

	int numStripes;

	CCArray* speedFactors;
	float scrollSpeed;

	CGSize screenSize;
}

@end
