//
//  GameScene.m
//  Drop
//
//  Created by Aaron on 12-9-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"

@interface GameScene (PrivateMethods)
-(void) preloadParticleEffects:(NSString*)particleFile;
@end

@implementation GameScene
@synthesize script;
@synthesize bulletCache;
@synthesize healthbar;
static CGRect screenRect;
static GameScene* instanceOfGameScene;
+(GameScene*) sharedGameScene
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
}
+(CCScene *)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameScene node];
    [scene addChild:layer];
    return scene;
}
-(id) init
{
    if((self = [super init]))
    {
        instanceOfGameScene = self;
        
        //打开重力感应
        self.isAccelerometerEnabled = YES;
        
        screenSize = [[CCDirector sharedDirector] winSize];
        
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
        
        // Load all of the game's artwork up front.
		CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[frameCache addSpriteFramesWithFile:@"resource.plist"];
                
        ParallaxBackground* background = [ParallaxBackground node];
		[self addChild:background z:-1];
        
        [self initPauseButton];
        
        //player initiation
        [self initPlayer];
        
        //生命条
        healthbar = [HealthbarComponent healthbarComponent];
        [healthbar reset];
        [self addChild:healthbar];
        
        //初始化bulletcache
        bulletCache = [BulletCache node];
        [self addChild:bulletCache z:1 tag:BulletCacheTag];
        
        //初始化Enemy
        enemyCache = [EnemyCache node];
		[self addChild:enemyCache z:0 tag:EnemyCacheTag];
        
        
        //初始化脚本,要在EnemyCache之后
        Script* s = [Episode1 script];
        [self resetScript:s];
        
        // To preload the textures, play each effect once off-screen
		[self preloadParticleEffects:@"explosion.plist"];
        
        // Preload sound effects
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"explosion.wav"];
        
        [self scheduleUpdate];
        
        CCLOG(@"Game scene inited");
        
    }
    return self;
}

-(void) checkForBulletCollisions
{
	Enemy* enemy;
	CCARRAY_FOREACH([enemyCache.batch children], enemy)
	{
		if (enemy.visible)
		{
			CGRect bbox = [enemy boundingBox];
			if ([bulletCache isPlayerBulletCollidingWithRect:bbox])
			{
				// This enemy got hit ...
				[enemy gotHit];
			}
		}
	}
}

-(void) onEnter
{
    //需要手动开启重力，CCLayer的onEnter没有恢复重力的功能，貌似是个bug
    if( isAccelerometerEnabled_ )
		[[UIAccelerometer sharedAccelerometer] setDelegate:self];
    [super onEnter];
}

-(void) resetScript:(Script*)theScript
{
    //这里一定要用self.script,即调用[self setScript]，会自动retain
    self.script = theScript;
    currentAction = 0;
    scriptActionInterval = 0;
    //重置
    int num = [script.scriptActions count];
    if (scriptParams != NULL) {
        free(scriptParams);
    }
    scriptParams = (ScriptParams*)malloc(num * sizeof(ScriptParams));
    for (int i=0; i<num; i++) {
        scriptParams[i].spawnedNum = 0;
        scriptParams[i].spawningTime = 0;
    }
}

-(void)update:(ccTime)delta
{
    scriptActionInterval += delta;
    //script执行完毕，应该结束了
//    if (currentAction >=[script.scriptActions count]) {
//        //TODO 更加高级的结束方式
//        [self unscheduleUpdate];
//        return;
//    }
    //按照顺序与间隔时间依次激活Action
    if (currentAction == 0 && ((ScriptAction*)[script.scriptActions objectAtIndex:currentAction]).status == InactiveState) {
        ((ScriptAction*)[script.scriptActions objectAtIndex:currentAction]).status = ActiveState;
    }
    if (scriptActionInterval >= ((ScriptAction*)[script.scriptActions objectAtIndex:currentAction]).nextActionInterval) {
        if (currentAction + 1 < [script.scriptActions count]) {
            //转到下个action
            currentAction++;
            ((ScriptAction*)[script.scriptActions objectAtIndex:currentAction]).status = ActiveState;
        }
    }
    //孵化敌人
    for (int i=0; i<[script.scriptActions count]; i++) {
        ScriptAction* action = [script.scriptActions objectAtIndex:i];
        //只对激活的Action操作
        if (action.status == ActiveState) {
            scriptParams[i].spawningTime += delta;
            //孵化时间达到要求，开始孵化
            if (scriptParams[i].spawningTime >= action.interval) {
                //TODO spawn enemy
//                enemyCache = (EnemyCache*)[self getChildByTag:BulletCacheTag];
                [enemyCache spawnEnemyOfType:action.type startPosition:action.startPosition moveComponent:action.moveComponent];
                
                scriptParams[i].spawnedNum++;
                //看是不是完成Action了
                if (scriptParams[i].spawnedNum >= action.num) {
                    //完成，设置Action状态为已完成
                    action.status = FinishedState;
                }else{
                    //否则孵化时间再次清零，为下一次孵化做准备
                    scriptParams[i].spawningTime = 0;
                }
            }
        }
    }
    [self checkForBulletCollisions];
}

-(void) preloadParticleEffects:(NSString*)particleFile
{
	[CCParticleSystemQuad particleWithFile:particleFile];
}

-(void) initPauseButton
{
    CCMenuItemSprite* pause = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"pause.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"resume.png"] target:self selector:@selector(doPause:)];
    CCMenu *menu = [CCMenu menuWithItems:pause, nil];
    menu.position = ccp(screenSize.width - pause.contentSize.width,screenSize.height - pause.contentSize.height);
    [self addChild:menu z:10];
}

-(void) doPause : (CCMenuItem*) menuItem
{
    CCLOG(@"pause game");
//    [[CCDirector sharedDirector] pushScene:[PauseScene scene]];
    
    [PauseLayer layerWithDelegate:self];
}

-(void) initPlayer
{
    player = [Ship ship];
    float imageHeight = [player textureRect].size.height;
    player.position = ccp(screenSize.width * 0.5f,imageHeight * 0.5f);
    [self addChild:player];
}

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    //重力感应
    float deceleration = 0.4f;
    
    float sensitivity = 6.0f;
    
    float maxVelocity = 100;
    Ship* ship = [Ship sharedShip];
    CGPoint pos = ccp(ship.playerVelocity.x * deceleration + acceleration.x * sensitivity,ship.playerVelocity.y);
    ship.playerVelocity  = pos;
    if(ship.playerVelocity.x > maxVelocity)
    {
        pos.x = maxVelocity;
        ship.playerVelocity = pos;
    }else if(ship.playerVelocity.x < -maxVelocity)
    {
        pos.x = -maxVelocity;
        ship.playerVelocity = pos;
    }
}

-(void) dealloc
{
    CCLOG(@"Game dealloc");
    if (scriptParams != NULL) {
        free(scriptParams);
    }
    [super dealloc];
}
+(CGRect)screenRect
{
    return screenRect;
}
@end