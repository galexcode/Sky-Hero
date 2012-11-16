//
//  Bullet.h
//  Drop
//
//  Created by Aaron on 12-10-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Bullet : CCSprite {
    CGPoint velocity;
    bool isPlayerBullet;
    CGPoint lastPosition;
}
@property (readwrite,nonatomic) CGPoint velocity;
@property (readwrite,nonatomic) bool isPlayerBullet;

+(id) bullet;

-(void) shootBulletAt:(CGPoint)startPosition velocity:(CGPoint)vel frameName:(NSString*)frameName isPlayerBullet:(bool) playerBullet;
@end
