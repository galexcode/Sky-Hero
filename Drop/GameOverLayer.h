//
//  GameOverLayer.h
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//@interface CCNode(PauseLayerHelper)
//
//-(void)pauseLayerDidPause;
//
//-(void)pauseLayerDidUnpause;
//
//@end

@interface GameOverLayer : CCLayerColor {
    
    CCNode * delegate;
}

@property (nonatomic,assign)CCNode * delegate;

+ (id) layerWithDelegate:(CCNode *)_delegate;

- (id) initWithDelegate:(CCNode *)_delegate;

-(void)pauseDelegate;

@end
