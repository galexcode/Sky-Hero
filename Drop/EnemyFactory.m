//
//  EnemyFactory.m
//  Drop
//
//  Created by Aaron on 12-10-18.
//
//

#import "EnemyFactory.h"
#import "UFO.h"
#import "Fighter.h"
#import "Bat.h"

@implementation EnemyFactory
+(Enemy*) enemyWithType:(EnemyTypes)enemyType
{
    switch (enemyType) {
        case UFOType:
            return [UFO enemy];
            break;
        case CruiserType:
            return [Fighter enemy];
            break;
        case BossType:
            return [Bat enemy];
            break;
        default:
            return nil;
            break;
    }
}
@end
