//
//  WindowNotifier.h
//  pbgrowl
//
//  Created by Yushi Nakai on 11/11/11.
//  Copyright (c) 2011年 Yushi Nakai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notifier.h"

@interface WindowNotifier : Notifier{
    NSTextField* field;
}
-(id)initWithTextField:(NSTextField*)field;
@end
