//
//  Ship.h
//  Drop
//
//  Created by Aaron on 12-10-11.
//
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "BasicShootComponent.h"

@interface Ship : Entity
{
    CGPoint playerVelocity;
    //游戏开始的时长
    ccTime totalTime;
    ccTime nextShotTime;
    
    BasicShootComponent* shootComponent;
}
+(Ship*)ship;
+(Ship*) sharedShip;
-(void) reset;
@property (nonatomic)CGPoint playerVelocity;
@end
