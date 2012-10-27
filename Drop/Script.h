//
//  Script.h
//  Drop
//
//  Created by Aaron on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import "ScriptAction.h"

@interface Script : NSObject
{
    NSMutableArray* scriptActions;
}
+(id) script;
@property (readonly,nonatomic)NSMutableArray* scriptActions;
@end
