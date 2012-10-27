//
//  BasicShootComponent.h
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BasicShootComponent : CCSprite {
    
    float shootFrequency;
    NSString* bulletFrameName;
}

@property (nonatomic) float shootFrequency;
//设置为copy属性，保证为值拷贝
@property (nonatomic,copy) NSString* bulletFrameName;
@end
