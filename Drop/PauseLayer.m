//
//  PauseLayer.m
//  Drop
//
//  Created by Aaron on 12-10-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"

@implementation PauseLayer

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
        CCMenuItemFont *resume = [CCMenuItemFont itemWithString:@"Resume" target:self selector:@selector(doResume:)];
        
        //language option
        CCMenuItemFont *back = [CCMenuItemFont itemWithString:@"Main Menu" target:self selector:@selector(doBackToMainMenu:)];
        
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

-(void)doResume: (id)sender

{
    //判断delegate中有无定义pauseLayerDidUnpause方法，有的话调用
    [delegate onEnter];
    
    if([delegate respondsToSelector:@selector(pauseLayerDidUnpause)])
        
        [delegate pauseLayerDidUnpause];
    
    [self.parent removeChild:self cleanup:YES];
    
}

-(void)doBackToMainMenu: (id)sender
{
    [[CCDirector sharedDirector] popScene];
}

-(void)dealloc

{
    
    [super dealloc];
    
}

@end
