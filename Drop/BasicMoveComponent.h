//
//  BasicMoveComponent.h
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BasicMoveComponent : CCSprite{
    CGPoint velocity;
    CGPoint acceleration;
    ccTime duration;
}
@property (readonly,nonatomic)CGPoint velocity;
@property (readonly,nonatomic)CGPoint acceleration;
@property (nonatomic)ccTime duration;
-(void)move;
@end
