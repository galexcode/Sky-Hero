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
#import "EnemyCache.h"
#import "HealthbarComponent.h"
#import "ParallaxBackground.h"
#import "SimpleAudioEngine.h"
#import "PauseLayer.h"
#import "Script.h"
#import "Episode1.h"

typedef enum
{
    BulletTag = 1,
    BulletSpriteBatchTag,
    BulletCacheTag,
    EnemyCacheTag,
    ShipTag,
}GameNodeTags;
typedef struct
{
    unsigned short spawnedNum;
    float spawningTime;
}ScriptParams;
@interface GameScene : CCLayer {
    CGSize screenSize;
    
    Ship *player;
    HealthbarComponent* healthbar;
    
    BulletCache* bulletCache;
    
    EnemyCache* enemyCache;
    
    //记录script action内的敌人生成的时间间隔
    ScriptParams* scriptParams;
    //script action的间隔时间
    float scriptActionInterval;
    Script* script;
    int currentAction;
    
    //分数label
    CCNode<CCLabelProtocol> *scoreLabel;
    //总分
    int score;
}
-(void) updateScore:(int)theScore;
+(GameScene*) sharedGameScene;
+(CCScene *) scene;
+(CGRect) screenRect;
@property (nonatomic,retain) Script* script;
@property (readonly,nonatomic) BulletCache* bulletCache;
@property (readonly,nonatomic) HealthbarComponent* healthbar;
@end
