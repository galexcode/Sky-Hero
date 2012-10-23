//
//  GameScene.h
//  Drop
//
//  Created by Aaron on 12-9-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Ship.h"
#import "BulletCache.h"
#import "HealthbarComponent.h"
typedef enum
{
    BulletTag = 1,
    BulletSpriteBatchTag,
    BulletCacheTag,
    EnemyCacheTag,
    ShipTag,
}GameNodeTags;
@interface GameScene : CCLayer {
    CGSize screenSize;
    
    Ship *player;
    HealthbarComponent* healthbar;
    
    BulletCache* bulletCache;
}
+(GameScene*) sharedGameScene;
+(CCScene *) scene;
+(CGRect) screenRect;
@property (readonly,nonatomic) BulletCache* bulletCache;
@property (readonly,nonatomic) HealthbarComponent* healthbar;
@end
