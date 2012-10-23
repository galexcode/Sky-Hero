#import "HealthbarComponent.h"
#import "Ship.h"
@interface HealthbarComponent(PrivateMethods)
-(id) initWithHealthbarImage;
@end

@implementation HealthbarComponent
+(HealthbarComponent*) healthbarComponent
{
    return [[[self alloc] initWithHealthbarImage] autorelease];
}

-(id) initWithHealthbarImage
{
    if ((self = [super init]))
	{
        title = [CCSprite spriteWithSpriteFrameName:@"healthbar_title.png"];
        healthbar = [CCSprite spriteWithSpriteFrameName:@"healthbar.png"];
        [self addChild:title];
        [self addChild:healthbar];
		self.visible = NO;
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) reset
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    self.anchorPoint = ccp(0,1);
	self.position = CGPointMake(20, screenSize.height - 20);
    title.anchorPoint = ccp(0,1);
    title.position = ccp(0,0);
    healthbar.anchorPoint = ccp(0, 1);
    healthbar.position = ccp(title.contentSize.width + 5,0);
    healthbar.scaleX = 1;
	self.visible = YES;
}

-(void) update:(ccTime)delta
{
	
    Ship* ship = [Ship sharedShip];
    //调整缩放比例
    healthbar.scaleX = ship.hitPoints / (float)ship.initialHitPoints;
	
}

@end
