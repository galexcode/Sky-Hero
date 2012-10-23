//
//  BulletCache.h
//  Drop
//
//  Created by Aaron on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BulletCache : CCNode {
    CCSpriteBatchNode* batch;
    int nextInactiveBullet;
}

-(void)shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)velocity frameName:(NSString*)frameName isPlayerBullet:(bool) playerBullet;

-(bool) isPlayerBulletCollidingWithRect:(CGRect)rect;
-(bool) isEnemyBulletCollidingWithRect:(CGRect)rect;
@end
