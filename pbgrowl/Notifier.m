//
//  Notifier.m
//  pbnotify
//
//  Created by 中井 優志 on 11/11/17.
//  Copyright (c) 2011年 Yushi Nakai. All rights reserved.
//

#import "Notifier.h"

@implementation Notifier
-(id)init{
    self = [super init];
    notifyType = @"";
    return self;
}

-(bool)setup{
    return YES;
}

-(void)notify:(NSString *)newString{

}

-(NSString*)getNotifyType{
    return notifyType;
}
@end
