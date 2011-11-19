//
//  PBWatcher.h
//  pbnotify
//
//  Created by Yushi Nakai on 11/11/10.
//  Copyright (c) 2011 Yushi Nakai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notifier.h"

@interface PBWatcher : NSObject{
    NSPasteboard* pb;
    NSString* lastData;
    NSArray* notifiers;
}

-(BOOL)setup;
-(void)setNotifiers:(NSArray*)notifiers;
-(NSArray*)getNotifiers;
-(void)removeNotifiersByType:(NSString*)type;
-(void)addNotifier:(id)notifier;
-(void)checkPasteboard;
-(void)notifyAll;
@end
