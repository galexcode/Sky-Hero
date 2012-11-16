//
//  VelocityShootComponent.m
//  Drop
//
//  Created by Aaron on 12-11-1.
//
//

#import "VelocityShootComponent.h"
#import "GameScene.h"

@implementation VelocityShootComponent
-(void)shoot:(CGPoint)velocity
{
    GameScene* game = [GameScene sharedGameScene];
    [game.bulletCache shootBulletAt:startPosition velocity:velocity frameName:bulletFrameName isPlayerBullet:NO];
    
    [super shoot];
}
@end
