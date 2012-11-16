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
#import "BattleShip.h"
#import "Striker.h"

@implementation EnemyFactory
+(Enemy*) enemyWithType:(EnemyTypes)enemyType
{
    switch (enemyType) {
        case UFOType:
            return [UFO enemy];
            break;
        case BatType:
            return [Bat enemy];
            break;
        case BattleshipType:
            return [BattleShip enemy];
            break;
        case FighterType:
            return [Fighter enemy];
            break;
        case StrikerType:
            return [Striker enemy];
            break;
        default:
            return nil;
            break;
    }
}
@end
