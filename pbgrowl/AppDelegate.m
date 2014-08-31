//
//  AppDelegate.m
//  pbnotify
//
//  Created by Yushi Nakai on 11/11/09.
//  Copyright (c) 2011 Yushi Nakai. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize preferences = _preferences;
@synthesize menu = _menu;
@synthesize enableNotificationCenterButton = _enableNotificationCenterButton;
@synthesize enableGrowlButton = _enableGrowlButton;
@synthesize toggleWindowButton = _toggleWindowButton;
@synthesize allwaysOnTopButton = _allwaysOnTopButton;
@synthesize startAtLoginButton = _startAtLoginButton;
@synthesize preferencesMenuItem = _preferencesMenuItem;
@synthesize pasteboardTextField = _pasteboardTextField;
@synthesize ignoreMouseButton = _ignoreMouseButton;
@synthesize opacitySlider = _opacitySlider;

static NSString *frameName = @"notifyWindow";

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)application
{
    [_window saveFrameUsingName:frameName];
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    setting = [[Setting alloc] init];
    
    [self setupStatusMenu];
    [self setupAction];
    [self setupUI];
        
    // setup Notifiers
    NSMutableArray* notifiers = [[NSMutableArray alloc] init ];
    WindowNotifier *wn = [self getWindowNotifier];
    [notifiers addObject:wn];

    pbw = [[PBWatcher alloc] init];
    [pbw setNotifiers:notifiers];
    if(![pbw setup]){
        NSLog(@"ERROR: init PBWatcher failed.");
        exit(-1);
    }
    [NSThread detachNewThreadSelector:@selector(run:)
                             toTarget:[AppDelegate class] withObject:pbw];
    [self enableGrowl:[setting isGrowlEnabled] ui:_enableGrowlButton];
    [self enableNotificationCenter:[setting isNotificationCenterEnabled] ui:_enableNotificationCenterButton];
}

-(void)setupStatusMenu{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setTitle:@""];
    [statusItem setImage:[NSImage imageNamed:@"pbnotify.tiff"]];
    [statusItem setToolTip:@"PBNotify"];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:_menu];
}

-(void)setupAction{
    [_enableNotificationCenterButton setTarget:self];
    [_enableNotificationCenterButton setAction:@selector(enableNotificationCenterNotificationClicked:)];

    [_enableGrowlButton setTarget:self];
    [_enableGrowlButton setAction:@selector(enableGrowlNotificationClicked:)];
    
    [_preferencesMenuItem setTarget:self];
    [_preferencesMenuItem setAction:@selector(openPreferencesClicked:)];
    
    [_toggleWindowButton setTarget:self];
    [_toggleWindowButton setAction:@selector(showWindowClicked:)];
    
    [_allwaysOnTopButton setTarget:self];
    [_allwaysOnTopButton setAction:@selector(allwaysOnTopClicked:)];
    
    [_startAtLoginButton setTarget:self];
    [_startAtLoginButton setAction:@selector(startAtLoginClicked:)];
    
    [_ignoreMouseButton setTarget:self];
    [_ignoreMouseButton setAction:@selector(ignoreMouseClicked:)];
    
    [_opacitySlider setTarget:self];
    [_opacitySlider setAction:@selector(opacitySliderChanged:)];
    
}

- (void)setupUI{
    [_opacitySlider setIntValue:(int)[setting getOpacity]];
    [self setOpacity:_opacitySlider];
    
    [self enableAllwaysOnTop:[setting isAllwaysOnTop]
                          ui:_allwaysOnTopButton];
    
    [self enableShowWindow:[setting isShowWindow]
                        ui:_toggleWindowButton];
    
    LaunchAtLoginController *launchController = [[LaunchAtLoginController alloc] init];
    if([launchController launchAtLogin]){
        [_startAtLoginButton setState:NSOnState];        
    }else{
        [_startAtLoginButton setState:NSOffState];        
    }
    
    [self ignoreMouse:[setting isIgnoreMouse] ui:_ignoreMouseButton];

    [self enableNotificationCenter:[setting isNotificationCenterEnabled] ui:_enableNotificationCenterButton];
    [self enableGrowl:[setting isGrowlEnabled] ui:_enableGrowlButton];
}

- (void)enableNotificationCenterNotificationClicked:(id)sender{
    int state = (int)[sender state];
    [self enableNotificationCenter:[self stateToBool:state]
                   ui:sender];
}

- (void)enableGrowlNotificationClicked:(id)sender{
    int state = (int)[sender state];
    [self enableGrowl:[self stateToBool:state]
                   ui:sender];
}

- (void)openPreferencesClicked:(id)sender{
    [_preferences setIsVisible:YES];
    [_preferences orderFrontRegardless];
}

- (void)showWindowClicked:(id)sender{
    int state = (int)[sender state];
    [self enableShowWindow:[self stateToBool:state]
                        ui:sender];
}

- (void)startAtLoginClicked:(id)sender{
    LaunchAtLoginController *launchController = [[LaunchAtLoginController alloc] init];
    BOOL isLaunchAtLogin = [launchController launchAtLogin];
    NSInteger state = [sender state];
    if(state == NSOnState){
        if(!isLaunchAtLogin){
            [launchController setLaunchAtLogin:YES];
        }
    }else if(state == NSOffState){
        if(isLaunchAtLogin){
            [launchController setLaunchAtLogin:NO];
        }
    }
}

-(void)menuWillOpen:(NSMenu *)sender{
    if([_window isVisible]){
        [_window orderFrontRegardless];
    }
    if([_preferences isVisible]){
        [_preferences orderFrontRegardless];
    }        
}

- (void)opacitySliderChanged:(id)sender{
    [self setOpacity:sender];
}

- (void)allwaysOnTopClicked:(id)sender{
    int state = (int)[sender state];
    [self enableAllwaysOnTop:[self stateToBool:state]
                          ui:sender];
}

- (void)ignoreMouseClicked:(id)sender{
    int state = (int)[sender state];
    [self ignoreMouse:[self stateToBool:state]
                   ui:sender];
}

- (NotificationCenterNotifier*)getNotificationCenterNotifier{
    NotificationCenterNotifier* nn = [[NotificationCenterNotifier alloc] init];
    return nn;
}

- (GrowlNotifier*)getGrowlNotifier{
    GrowlNotifier* gn = [[GrowlNotifier alloc] init];
    if(![gn setup]){
        NSLog(@"INFO: Could not load  Growl.framework");
        gn = nil;
    }
    return gn;
}

- (WindowNotifier*)getWindowNotifier{
    WindowNotifier* wn = [[WindowNotifier alloc] initWithTextField:_pasteboardTextField];
    return wn;
}

- (void)enableNotificationCenter:(_Bool)enable ui:(id)ui{
    if(enable){
        [pbw addNotifier:[self getNotificationCenterNotifier]];
        [pbw notifyAll];
    }else{
        [pbw removeNotifiersByType:@"notification_center"];
    }
    [ui setState:[self boolToState:enable]];
    [setting setIsNotificationCenterEnabled:enable];
}

- (void)enableGrowl:(_Bool)enable ui:(id)ui{
    if(enable){
        [pbw addNotifier:[self getGrowlNotifier]];
        [pbw notifyAll];
    }else{
        [pbw removeNotifiersByType:@"growl"];
    }
    [ui setState:[self boolToState:enable]];
    [setting setIsGrowlEnabled:enable];
}

- (void)ignoreMouse:(bool)ignore ui:(id)ui{
    [_window setIgnoresMouseEvents:ignore];
    [ui setState:[self boolToState:ignore]];
    [setting setIsIgnoreMouse:ignore];
}

- (void)setOpacity:(NSSlider *)slider{
    [_window setAlphaValue:([slider intValue] * 0.01)];
    [setting setOpacity:[slider intValue]];
}


- (void)enableShowWindow:(_Bool)enable ui:(id)ui{
    [ui setState:[self boolToState:enable]];
    [_window setFrameUsingName:frameName];
    [_window setIsVisible:enable];
    [_allwaysOnTopButton setEnabled:enable];
    [_ignoreMouseButton setEnabled:enable];
    [_opacitySlider setEnabled:enable];
    [setting setIsShowWindow:enable];
}

- (void)enableAllwaysOnTop:(bool)enable ui:(id)ui{
    if(enable){
        [_window setLevel:NSFloatingWindowLevel];
    }else{
        [_window setLevel:NSNormalWindowLevel];
    }
    [ui setState:[self boolToState:enable]];
    [setting setIsAllowOnTop:enable];
}

-(int)boolToState:(_Bool)enable{
    return enable ? NSOnState : NSOffState;
}

-(bool)stateToBool:(int)state{
    if(state == NSOffState){
        return NO;
    }
    return YES;
}
+(void)run:(id)pbw{
    const useconds_t sleep_time = 100000;
    while(1){
        @autoreleasepool {
            [pbw checkPasteboard];
            usleep(sleep_time);
        }
    }
    return;
}

@end
