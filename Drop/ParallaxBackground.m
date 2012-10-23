#import "ParallaxBackground.h"


@implementation ParallaxBackground

-(id) init
{
	if ((self = [super init]))
	{
		// The screensize never changes during gameplay, so we can cache it in a member variable.
		screenSize = [[CCDirector sharedDirector] winSize];
		
		// Get the game's texture atlas texture by adding it. Since it's added already it will simply return 
		// the CCTexture2D associated with the texture atlas.
		CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"resource.pvr.ccz"];
		
		// Create the background spritebatch
		spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
		[self addChild:spriteBatch];

        //背景数量
		numStripes = 4;
		
		// Add the 4 different stripes and position them on the screen
		for (int i = 0; i < numStripes; i++)
		{
			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
            //切换anchor
			sprite.anchorPoint = CGPointMake(0.5f,0);
			sprite.position = CGPointMake(screenSize.width * 0.5f, 0);
			[spriteBatch addChild:sprite z:i tag:i];
		}

		// Add 4 more stripes, flip them and position them next to their neighbor stripe
		for (int i = 0; i < numStripes; i++)
		{
			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
			
			// Position the new sprite one screen height to the top
			sprite.anchorPoint = CGPointMake(0.5f,0);
			sprite.position = CGPointMake(screenSize.width * 0.5f,screenSize.height - 1);

			// Flip the sprite so that it aligns perfectly with its neighbor
            //TODO not so sure of it
//			sprite.flipY = YES;
			
			// Add the sprite using the same tag offset by numStripes
			[spriteBatch addChild:sprite z:i tag:i + numStripes];
		}
		
		// Initialize the array that contains the scroll factors for individual stripes.
		speedFactors = [[CCArray alloc] initWithCapacity:numStripes];
		[speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.7f]];
		NSAssert([speedFactors count] == numStripes, @"speedFactors count does not match numStripes!");

		scrollSpeed = 1.0f;
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) dealloc
{
	[speedFactors release];
	[super dealloc];
}

-(void) update:(ccTime)delta
{
	CCSprite* sprite;
	CCARRAY_FOREACH([spriteBatch children], sprite)
	{
		//CCLOG(@"tag: %i", sprite.tag);
		NSNumber* factor = [speedFactors objectAtIndex:sprite.zOrder];
		
		CGPoint pos = sprite.position;
		pos.y -= scrollSpeed * [factor floatValue];
		
		// Reposition stripes when they're out of bounds
		if (pos.y < -screenSize.height)
		{
			pos.y += (screenSize.height * 2) - 2;
		}
		
		sprite.position = pos;
	}
}

@end
