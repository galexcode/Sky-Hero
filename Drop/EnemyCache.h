//
//  EnemyCache.h
//  Drop
//
//  Created by Aaron on 12-10-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyCache : CCSprite {
    CCSpriteBatchNode* batch;
    CCArray* enemies;
    
    int updateCount;
}

@end
