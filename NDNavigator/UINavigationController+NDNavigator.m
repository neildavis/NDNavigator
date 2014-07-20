//
//  UINavigationController+NDNavigator.m
//
//  Created by Neil Davis on 20/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "UINavigationController+NDNavigator.h"
#import "UIViewController+NDNavigator.h"
#import "NDNavigationMap.h"

@implementation UINavigationController (NDNavigator)

- (instancetype) initWithRootControllerURL:(NSURL*)url navigationMap:(NDNavigationMap*)navigationMap
{
    self.navigationMap = navigationMap;
    UIViewController *vc = [navigationMap viewControllerForURL:url];
    return [self initWithRootViewController:vc];
}

- (void) setRootViewControllerWithURL:(NSURL*)url
{
    UIViewController *vc = [self.navigationMap viewControllerForURL:url];
    if (vc)
    {
        self.viewControllers = @[vc];
    }
}

- (void) pushViewControllerWithURL:(NSURL*)url animated:(BOOL)animated
{
    UIViewController *vc = [self.navigationMap viewControllerForURL:url];
    if (vc)
    {
        [self pushViewController:vc animated:animated];
    }
}

@end
