//
//  HoverMoveComponent.h
//  Drop
//
//  Created by Aaron on 12-10-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BasicMoveComponent.h"

@interface HoverMoveComponent : BasicMoveComponent {
    CGPoint hoverPosition;
    ccTime hoverTime;
}
+(id)instanceWithHoverPosition:(CGPoint)theHoverPosition;
-(id)initWithHoverPosition:(CGPoint)theHoverPosition;
@property (nonatomic)ccTime delayTime;
@end
