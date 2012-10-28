//
//  BasicShootComponent.h
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicShootComponent : NSObject {
    CGPoint startPosition;
    NSString* bulletFrameName;
}

-(id) initWithStartPosition:(CGPoint)theStartPosition bulletFrameName:(NSString*)theBulletFrameName;
+(id) instanceWithStartPosition:(CGPoint)theStartPosition bulletFrameName:(NSString*)theBulletFrameName;
-(void)shoot;
@property (nonatomic)CGPoint startPosition;
@end
