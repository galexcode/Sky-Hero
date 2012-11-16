//
//  TribulletsShootComponent.m
//  Drop
//
//  Created by Aaron on 12-10-28.
//
//

#import "TribulletsShootComponent.h"
#import "GameScene.h"

@implementation TribulletsShootComponent
-(void)shoot
{
    GameScene* game = [GameScene sharedGameScene];
    [game.bulletCache shootBulletAt:startPosition velocity:ccp(0,200) frameName:bulletFrameName isPlayerBullet:YES];
    [game.bulletCache shootBulletAt:startPosition velocity:ccp(-60,200) frameName:bulletFrameName isPlayerBullet:YES];
    [game.bulletCache shootBulletAt:startPosition velocity:ccp(60,200) frameName:bulletFrameName isPlayerBullet:YES];
}
@end
