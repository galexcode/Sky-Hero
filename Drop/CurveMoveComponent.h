//
//  CurveMoveComponent.h
//  Drop
//
//  Created by Aaron on 12-10-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BasicMoveComponent.h"

@interface CurveMoveComponent : BasicMoveComponent {
    ccBezierConfig bezierConfig;
}
+(id)instanceWithBezierConfig:(ccBezierConfig)theBezierConfig;
//-(id)initWithBezierConfig:(ccBezierConfig)theBezierConfig;
@end
