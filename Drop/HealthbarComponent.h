#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HealthbarComponent : CCSprite 
{
    CCSprite* title;
    CCSprite* healthbar;
}

-(void) reset;
+(HealthbarComponent*) healthbarComponent;
@end
