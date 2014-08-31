//
//  NotificationCenterNotifier.m
//  PBNotify
//
//  Created by Yushi Nakai on 8/30/14.
//  Copyright (c) 2014 Yushi Nakai. All rights reserved.
//

#import "NotificationCenterNotifier.h"

@implementation NotificationCenterNotifier

-(bool)setup{
    return YES;
}

-(void)notify:(NSString*)newString{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"PBNotify";
    notification.informativeText = newString;
    notification.soundName = NSUserNotificationDefaultSoundName;

    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:  notification];
}

@end
