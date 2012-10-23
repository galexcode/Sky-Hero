//
//  OptionsScene.m
//  Drop
//
//  Created by Aaron on 12-10-21.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "OptionsScene.h"


@implementation OptionsScene
+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [OptionsScene node];
    [scene addChild:layer];
    return scene;
}

-(id) init
{
    if (self = [super init]) {
        //set up menus
        [self setUpOptions];
    }
    return self;
}

-(void) setUpOptions
{
    //sound option
//    [CCMenuItemFont setFontSize:18];
    CCMenuItemFont* soundOn = [CCMenuItemFont itemWithString:@"Sound On"];
    CCMenuItemFont* soundOff = [CCMenuItemFont itemWithString:@"Sound Off"];
    CCMenuItemToggle *soundOption = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundOptionTouched:) items:soundOn,soundOff, nil];
    
    //language option
    CCMenuItemFont *back = [CCMenuItemFont itemWithString:@"Main Menu" target:self selector:@selector(backToMain:)];
    
    CCMenu *menu = [CCMenu menuWithItems:soundOption,back, nil];
    
    [menu alignItemsVertically];
    
    [self addChild:menu];
}

-(void) soundOptionTouched: (CCMenuItem  *) menuItem
{
    CCLOG(@"Sound state changed");
}

-(void) backToMain: (CCMenuItem  *) menuItem
{
    //pop the scene and return to the main screen
    [[CCDirector sharedDirector] popScene];
}
@end
