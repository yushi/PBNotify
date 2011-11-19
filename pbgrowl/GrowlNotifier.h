//
//  GrowlNotifier.h
//  pbgrowl
//
//  Created by Yushi Nakai on 11/11/11.
//  Copyright (c) 2011年 Yushi Nakai. All rights reserved.
//

#import <Growl/Growl.h>
#import "Notifier.h"

@interface GrowlNotifier : Notifier < GrowlApplicationBridgeDelegate>
@end
