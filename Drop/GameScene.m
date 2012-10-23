//
//  GameScene.m
//  Drop
//
//  Created by Aaron on 12-9-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "EnemyCache.h"
#import "ParallaxBackground.h"
#import "SimpleAudioEngine.h"
#import "PauseLayer.h"

@interface GameScene (PrivateMethods)
-(void) preloadParticleEffects:(NSString*)particleFile;
@end

@implementation GameScene
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
        EnemyCache* enemyCache = [EnemyCache node];
		[self addChild:enemyCache z:0 tag:EnemyCacheTag];
        
        // To preload the textures, play each effect once off-screen
		[self preloadParticleEffects:@"explosion.plist"];
        
        // Preload sound effects
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"explosion.wav"];
        
//        [self scheduleUpdate];
        
        CCLOG(@"Game scene inited");
        
    }
    return self;
}

-(void) onEnter
{
    //需要手动开启重力，CCLayer的onEnter没有恢复重力的功能，貌似是个bug
    if( isAccelerometerEnabled_ )
		[[UIAccelerometer sharedAccelerometer] setDelegate:self];
    [super onEnter];
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
    [super dealloc];
}
+(CGRect)screenRect
{
    return screenRect;
}
@end

