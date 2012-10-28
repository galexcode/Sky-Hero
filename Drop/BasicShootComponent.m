//
//  BasicShootComponent.m
//  Drop
//
//  Created by Aaron on 12-10-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BasicShootComponent.h"


@implementation BasicShootComponent
@synthesize startPosition;
+(id)instanceWithStartPosition:(CGPoint)theStartPosition bulletFrameName:(NSString*)theBulletFrameName
{
    return [[self alloc]initWithStartPosition:theStartPosition bulletFrameName:theBulletFrameName];
}

-(id) initWithStartPosition:(CGPoint)theStartPosition bulletFrameName:(NSString*)theBulletFrameName
{
    if(self = [super init])
    {
        startPosition = theStartPosition;
        bulletFrameName = theBulletFrameName;
    }
    return self;
}

-(void)shoot
{
    
}
@end
