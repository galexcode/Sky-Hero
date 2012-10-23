//
//  GameOverLayer.m
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameScene.h"
#import "Ship.h"


@implementation GameOverLayer

@synthesize delegate;

+ (id) layerWithDelegate:(CCNode*)_delegate

{
    
    return [[[self alloc] initWithDelegate:_delegate] autorelease];
    
}

- (id) initWithDelegate:(id)_delegate
{
    ccColor4B c = {0,0,0,150};
    self = [super initWithColor:c];
    
    if (self != nil) {
        
        CGSize wins = [[CCDirector sharedDirector] winSize];
        
        delegate = _delegate;
        
        //暂停 game layer
        [self pauseDelegate];
        
        //加入背景
        CCSprite * background = [CCSprite spriteWithSpriteFrameName:@"bg1.png"];
        
        [self addChild:background];
        
        //        CCMenuItemSprite* resume = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"resume.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"resume.png"] target:self selector:@selector(doResume:)];
        //sound option
        
        //title
        CCLabelTTF* title = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Zapfino" fontSize:40];
        title.position = ccp([background boundingBox].size.width/2,[background boundingBox].size.height * 0.8);
        [background addChild:title];
        
        //buttons
        CCMenuItemFont *resume = [CCMenuItemFont itemWithString:@"Continue" target:self selector:@selector(doContinue:)];
        
        //language option
        CCMenuItemFont *back = [CCMenuItemFont itemWithString:@"Quit" target:self selector:@selector(doQuit:)];
        
        CCMenu * menu = [CCMenu menuWithItems:resume,back,nil];
        
        [menu setPosition:ccp(0,0)];
        
        [resume setPosition:ccp([background boundingBox].size.width/2,[background boundingBox].size.height * 0.6)];
        
        [back setPosition:ccp([background boundingBox].size.width/2,[background boundingBox].size.height * 0.5)];
        
        [background addChild:menu];
        
        [background setPosition:ccp(wins.width/2,wins.height/2)];
        
    }
    
    return self;
    
}

-(void)pauseDelegate

{
    //判断delegate中有无定义pauseLayerDidPause方法，有的话调用
    if([delegate respondsToSelector:@selector(pauseLayerDidPause)])
        
        [delegate pauseLayerDidPause];
    
    [delegate onExit];
    
    [delegate.parent addChild:self z:10];
    
}

-(void)doContinue: (id)sender

{
    //判断delegate中有无定义pauseLayerDidUnpause方法，有的话调用
    [delegate onEnter];
    
    if([delegate respondsToSelector:@selector(pauseLayerDidUnpause)])
        
        [delegate pauseLayerDidUnpause];
    
    //重置生命条
    [[Ship sharedShip] reset];
    [[GameScene sharedGameScene].healthbar reset];
    
    [self.parent removeChild:self cleanup:YES];
    
}

-(void)doQuit: (id)sender
{
    [[CCDirector sharedDirector] popScene];
}

-(void)dealloc

{
    
    [super dealloc];
    
}

@end

