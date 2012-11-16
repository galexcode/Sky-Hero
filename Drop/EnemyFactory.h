//
//  EnemyFactory.h
//  Drop
//
//  Created by Aaron on 12-10-18.
//
//

#import "Enemy.h"
@interface EnemyFactory : NSObject

+(Enemy*) enemyWithType:(EnemyTypes)enemyType;
@end
