//
//  BasicMoveComponent.h
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Initiation.h"

@interface BasicMoveComponent : CCSprite <Initiation>{
    CGPoint velocity;
    CGPoint acceleration;
}
@property (readonly,nonatomic)CGPoint velocity;
@property (readonly,nonatomic)CGPoint acceleration;
-(void)move;
@end
