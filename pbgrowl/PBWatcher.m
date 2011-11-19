//
//  PBWatcher.m
//  pbwatcher
//
//  Created by Yushi Nakai on 11/11/10.
//  Copyright (c) 2011 Yushi Nakai. All rights reserved.
//

#import "PBWatcher.h"

@implementation PBWatcher

-(id)init{
    self = [super init];
    return self;
}

-(void)setNotifiers:(NSArray *)_notifiers{
    notifiers = _notifiers;
}

-(NSArray*)getNotifiers{
    return notifiers;
}

-(BOOL)setup{
    BOOL ret = NO;
    pb = [NSPasteboard generalPasteboard];
    if(pb){
        ret = YES;
    }
    return ret;
}

-(void)checkPasteboard{
    NSString* data = [pb stringForType:NSStringPboardType];
    if(!data){
        return;
    }

    if(![lastData isEqualToString:data]){
        lastData = data;
        [self notifyAll];
    }
}

-(void)notifyAll{
    for(NSUInteger i = 0; i < [notifiers count]; i++){
        [[notifiers objectAtIndex:i] notify:lastData];
    }
}

-(void)removeNotifiersByType:(NSString *)type{
    NSMutableArray* newNotifiers = [[NSMutableArray alloc] init ];
    for(NSUInteger i = 0; i < [notifiers count]; i++){
        id notifier = [notifiers objectAtIndex:i];
        if(![type isEqualToString:[notifier getNotifyType]]){
            [newNotifiers addObject:notifier];
        }
    }
    [self setNotifiers:newNotifiers];    
}

-(void)addNotifier:(id)notifier{
    NSMutableArray* newNotifiers = [[NSMutableArray alloc] init ];
    for(NSUInteger i = 0; i < [notifiers count]; i++){
        [newNotifiers addObject:[notifiers objectAtIndex:i]];
    }
    [newNotifiers addObject:notifier];
    [self setNotifiers:newNotifiers];
}
@end
