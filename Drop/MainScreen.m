//
//  MainScreen.m
//  Drop
//
//  Created by Aaron on 12-10-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainScreen.h"
#import "GameScene.h"
#import "OptionsScene.h"


@implementation MainScreen
+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [MainScreen node];
    [scene addChild:layer];
    return scene;
}

-(id) init
{
    if (self = [super init]) {
        //set up menus
        [self setUpMenus];
    }
    return self;
}

-(void) setUpMenus
{
//    CCMenuItemImage *item1 = [CCMenuItemImage itemWithNormalImage:@"myfirstbutton.png"  selectedImage:@"myfirstbutton_selected.png" target:self selector:@selector(doSomethingOne:)];
    CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"Start" target:self selector:@selector(startGame:)];
    
    CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"Options" target:self selector:@selector(startOptions:)];
    
    CCMenu *menu = [CCMenu menuWithItems:item1,item2, nil];
    
    [menu alignItemsVertically];
    
    [self addChild:menu];

}
- (void) startGame: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] pushScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene scene] withColor:ccWHITE]];
}

- (void) startOptions: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] pushScene:[OptionsScene scene]];
}
@end
