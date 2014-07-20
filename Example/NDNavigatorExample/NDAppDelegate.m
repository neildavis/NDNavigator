//
//  NDAppDelegate.m
//  NDNavigatorExample
//
//  Created by Neil Davis on 19/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "NDAppDelegate.h"
#import "NDViewControllersAssembly.h"
#import "NDSimpleViewControllerFactory.h"

#import "NDNavigationMap.h"
#import "UINavigationController+NDNavigator.h"

#import "NDRootViewController.h"
#import "NDBlueViewController.h"
#import "NDGreenViewController.h"

#import "Typhoon.h"

@interface NDAppDelegate ()

@property (nonatomic, strong) TyphoonComponentFactory *typhoonFactory;
@property (nonatomic, strong) NDSimpleViewControllerFactory *simpleFactory;
@property (nonatomic, strong) NDNavigationMap *navigationMap;

@end

@implementation NDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Create a navigation map for URL handling
    self.navigationMap = [[NDNavigationMap alloc] init];
    // Map some URLs onto view controllers
    [_navigationMap mapFromHost:@"root" toViewController:[NDRootViewController class]];     // myapp://root/
    [_navigationMap mapFromHost:@"blue" toViewController:[NDBlueViewController class]];     // myapp://blue/
    [_navigationMap mapFromHost:@"blue" toViewController:[NDBlueViewController class] withPathPattern:@"/:msgId/:msgText" willNavigateSelector:@selector(setMessageWithId:text:)];     // myapp://blue/<id>/<message>
    [_navigationMap mapFromHost:@"green" toViewController:[NDGreenViewController class]];   // myapp://green/?msgId=<id>&msgText=<message>
    
    // Create view controller factory. Factory strategy is determines by Settings bundle value
    [self setupViewControllersFactory];
    
    // Create and install navigation controller, with root view created from factory
    NSURL *rootURL = [NSURL URLWithString:@"myapp://root/"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootControllerURL:rootURL navigationMap:_navigationMap];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) setupViewControllersFactory
{
    __weak NDAppDelegate *weakSelf = self;
    // Get facory type from settings
    NSInteger factorySetting = [[NSUserDefaults standardUserDefaults] integerForKey:@"NSUD_FACTORY"];
    switch (factorySetting) {
        case 1:     // Simple - provide view controller instances to _navigationMap via simple factory
            {
                self.typhoonFactory = nil;
                self.simpleFactory = [[NDSimpleViewControllerFactory alloc] init];
                // Set navigation map factory to use simple factory
                _navigationMap.factoryBlock = (id)^(Class class) {
                    return [weakSelf.simpleFactory viewControllerForClass:class];
                };
            }
            break;
        case 2:     // Typhoon - provide view controller instances to _navigationMap via Typhoon resolution
            {
                self.simpleFactory = nil;
                self.typhoonFactory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[[NDViewControllersAssembly assembly]]];
                // Set navigation map factory to use Typhoon
                _navigationMap.factoryBlock = (id)^(Class class) {
                    return [weakSelf.typhoonFactory componentForType:class];
                };
            }
            break;
        default:    // None - _navigationMap will attempt to create view controller instances itself
            self.simpleFactory = nil;
            self.typhoonFactory = nil;
            break;
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self setupViewControllersFactory]; // Settings may have chnaged factory
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
