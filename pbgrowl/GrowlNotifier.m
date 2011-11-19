//
//  GrowlNotifier.m
//  pbgrowl
//
//  Created by Yushi Nakai on 11/11/11.
//  Copyright (c) 2011年 Yushi Nakai. All rights reserved.
//

#import "GrowlNotifier.h"

@implementation GrowlNotifier
-(id)init{
    self = [super init];
    notifyType = @"growl";
    return self;
}

-(bool)setup{
    NSBundle *myBundle = [NSBundle bundleForClass:[GrowlNotifier class]];
    NSString *growlPath = [[myBundle privateFrameworksPath] stringByAppendingPathComponent:@"Growl.framework"];
    NSBundle *growlBundle = [NSBundle bundleWithPath:growlPath];
    if(growlBundle && [growlBundle load]){
        return YES;
    }else{
        return NO;
    }
}

-(void)notify:(NSString*)newString{
    [GrowlApplicationBridge setGrowlDelegate:self];
    [GrowlApplicationBridge notifyWithTitle:@"PBNotify update"
                                description:newString
                           notificationName:@"PBNotify"
                                   iconData:nil
                                   priority:0
                                   isSticky:NO
                               clickContext:[NSDate date]
     ];

}

@end
