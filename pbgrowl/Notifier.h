//
//  Notifier.h
//  pbnotify
//
//  Created by 中井 優志 on 11/11/17.
//  Copyright (c) 2011年 Yushi Nakai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notifier : NSObject{
    NSString* notifyType;
}
-(id)init;
-(bool)setup;
-(void)notify:(NSString*)newString;
-(NSString*)getNotifyType;
@end
