//
//  WindowNotifier.m
//  pbgrowl
//
//  Created by Yushi Nakai on 11/11/11.
//  Copyright (c) 2011年 Yushi Nakai. All rights reserved.
//

#import "WindowNotifier.h"

@implementation WindowNotifier
-(id)init{
    self = [super init];
    notifyType = @"window";
    return self;
}

-(id)initWithTextField:(NSTextField *)_field{
    self = [super init];
    notifyType = @"window";
    field = _field;
    return self;
}

-(void)notify:(NSString*)newString{
    [field setObjectValue:newString];
}

-(NSString*)getNotifyType{
    return notifyType;
}

@end
