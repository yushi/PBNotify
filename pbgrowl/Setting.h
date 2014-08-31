//
//  Setting.h
//  pbnotify
//
//  Created by Yushi Nakai on 11/11/15.
//  Copyright (c) 2011年 Yushi Nakai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setting : NSObject{
    NSUserDefaults *defaults;
}
-(id)init;

//getter
-(int)getOpacity;
-(bool)isAllwaysOnTop;
-(bool)isShowWindow;
-(bool)isIgnoreMouse;
-(bool)isNotificationCenterEnabled;
-(bool)isGrowlEnabled;

//setter
-(void)setOpacity:(int)opacity;
-(void)setIsAllowOnTop:(bool)enable;
-(void)setIsShowWindow:(bool)enable;
-(void)setIsIgnoreMouse:(bool)enable;
-(void)setIsNotificationCenterEnabled:(bool)enable;
-(void)setIsGrowlEnabled:(bool)enable;
-(void)setBool:(_Bool)enable forKey:(NSString*)key;

@end
