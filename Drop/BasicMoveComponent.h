//
//  BasicMoveComponent.h
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BasicMoveComponent : NSObject <NSCopying>{
    CGPoint velocity;
    CGPoint acceleration;
    ccTime duration;
    CCAction* action;
}
@property (readonly,nonatomic)CGPoint velocity;
@property (readonly,nonatomic)CGPoint acceleration;
@property (nonatomic)ccTime duration;
@property (nonatomic,readonly)CCAction *action;
-(CCAction*)move;
-(id) copyWithCommonVars:(BasicMoveComponent*)moveCopy;
@end
