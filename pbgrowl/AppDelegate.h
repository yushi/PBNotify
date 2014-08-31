//
//  AppDelegate.h
//  pbgrowl
//
//  Created by Yushi Nakai on 11/11/09.
//  Copyright (c) 2011 Yushi Nakai. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GrowlNotifier.h"
#import "NotificationCenterNotifier.h"
#import "WindowNotifier.h"
#import "LaunchAtLoginController.h"
#import "PBWatcher.h"
#import "Setting.h"
#include <unistd.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    PBWatcher *pbw;
    NSStatusItem *statusItem;
    Setting *setting;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *preferences;
@property (assign) IBOutlet NSMenu *menu;
@property (assign) IBOutlet NSButton *enableNotificationCenterButton;
@property (assign) IBOutlet NSButton *enableGrowlButton;
@property (assign) IBOutlet NSButton *toggleWindowButton;
@property (assign) IBOutlet NSButton *allwaysOnTopButton;
@property (assign) IBOutlet NSButton *startAtLoginButton;
@property (assign) IBOutlet NSMenuItem *preferencesMenuItem;
@property (assign) IBOutlet NSButton *ignoreMouseButton;
@property (assign) IBOutlet NSTextField *pasteboardTextField;
@property (assign) IBOutlet NSSlider *opacitySlider;

- (void)setupStatusMenu;
- (void)setupAction;
- (void)setupUI;

// action handler
- (void)enableNotificationCenterClicked:(id)sender;
- (void)enableGrowlNotificationClicked:(id)sender;
- (void)openPreferencesClicked:(id)sender;
- (void)showWindowClicked:(id)sender;
- (void)allwaysOnTopClicked:(id)sender;
- (void)startAtLoginClicked:(id)sender;
- (void)ignoreMouseClicked:(id)sender;
- (void)opacitySliderChanged:(id)sender;

// for menu delegate
-(void)menuWillOpen:(NSMenu*)sender;

// for internal process
- (GrowlNotifier*)getGrowlNotifier;
- (WindowNotifier*)getWindowNotifier;
- (void)enableNotificationCenter:(bool)enable ui:(id)ui;
- (void)enableGrowl:(bool)enable ui:(id)ui;
- (void)setOpacity:(NSSlider*)slider;
- (void)ignoreMouse:(bool)ignore ui:(id)ui;
- (void)enableShowWindow:(bool)enable ui:(id)ui;
- (void)enableAllwaysOnTop:(bool)enable ui:(id)ui;
- (int)boolToState:(bool)enable;
- (bool)stateToBool:(int)state;
@end
