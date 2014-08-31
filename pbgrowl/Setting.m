//
//  Setting.m
//  pbnotify
//
//  Created by Yushi Nakai on 11/11/15.
//  Copyright (c) 2011年 Yushi Nakai. All rights reserved.
//

#import "Setting.h"
static NSString* KEY_OPACITY = @"opacity";
static NSString* KEY_SHOW_WINDOW = @"showWindow";
static NSString* KEY_ALLWAYS_ON_TOP = @"allwaysOnTop";
static NSString* KEY_NOTIFICATION_CENTER = @"notification_center";
static NSString* KEY_GROWL = @"growl";
static NSString* KEY_IGNORE_MOUSE = @"ignoreMouse";

@implementation Setting
-(id)init{
    self = [super init];
    defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *defaultDict = [NSMutableDictionary dictionary];
    [defaultDict setObject:@"100" forKey:KEY_OPACITY];
    [defaultDict setObject:@"YES" forKey:KEY_SHOW_WINDOW];
    [defaultDict setObject:@"NO" forKey:KEY_ALLWAYS_ON_TOP];
    [defaultDict setObject:@"NO" forKey:KEY_NOTIFICATION_CENTER];
    [defaultDict setObject:@"NO" forKey:KEY_GROWL];
    [defaultDict setObject:@"NO" forKey:KEY_IGNORE_MOUSE];
    [defaults registerDefaults:defaultDict];
    return self;
}

-(int)getOpacity{
    return (int)[defaults integerForKey:KEY_OPACITY];
}

-(bool)isAllwaysOnTop{
    return [defaults boolForKey:KEY_ALLWAYS_ON_TOP];
}

-(bool)isShowWindow{
    return [defaults boolForKey:KEY_SHOW_WINDOW];
}

-(bool)isIgnoreMouse{
    return [defaults boolForKey:KEY_IGNORE_MOUSE];
}

-(bool)isNotificationCenterEnabled{
    return [defaults boolForKey:KEY_NOTIFICATION_CENTER];
}

-(bool)isGrowlEnabled{
    return [defaults boolForKey:KEY_GROWL];
}

-(void)setOpacity:(int)opacity{
    [defaults setInteger:opacity forKey:KEY_OPACITY];
    
}

-(void)setIsAllowOnTop:(_Bool)enable{
    [self setBool:enable forKey:KEY_ALLWAYS_ON_TOP];
}

-(void)setIsShowWindow:(_Bool)enable{
    [self setBool:enable forKey:KEY_SHOW_WINDOW];
}

-(void)setIsIgnoreMouse:(_Bool)enable{
    [self setBool:enable forKey:KEY_IGNORE_MOUSE];
}

-(void)setIsNotificationCenterEnabled:(_Bool)enable{
    [self setBool:enable forKey:KEY_NOTIFICATION_CENTER];
}

-(void)setIsGrowlEnabled:(_Bool)enable{
    [self setBool:enable forKey:KEY_GROWL];
}

-(void)setBool:(_Bool)enable forKey:(NSString*)key{
    NSString *val = enable ? @"YES" : @"NO";
    [defaults setObject:val forKey:key];
}
@end
