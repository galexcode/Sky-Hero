//
//  EnemyFactory.h
//  Drop
//
//  Created by Aaron on 12-10-18.
//
//

#import <Foundation/Foundation.h>
#import "Enemy.h"

@interface EnemyFactory : NSObject

+(Enemy*) enemyWithType:(EnemyTypes)enemyType;
@end
