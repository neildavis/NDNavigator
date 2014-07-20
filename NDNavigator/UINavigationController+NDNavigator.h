//
//  UINavigationController+NDNavigator.h
//
//  Created by Neil Davis on 20/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NDNavigationMap;

/**
 Cateogory to allow setting/pushing UIViewController instances by URL
 */
@interface UINavigationController (NDNavigator)

/**
 Initializer.
 @param url the URL to match to a view controller to be used as the root view controller
 @param navigationMap An instance of NDNavigationMap used to map URLs to UIViewController objects
 */
- (instancetype) initWithRootControllerURL:(NSURL*)url navigationMap:(NDNavigationMap*)navigationMap;

/**
 Helper to set a view controller as the navigation stack root from a URL
 @param url the URL to match to a view controller to be used as the root view controller
 @discussion the navigationMap property MUST be valid to function correctly
 */
- (void) setRootViewControllerWithURL:(NSURL*)url;

/**
 Helper to push a view controller onto the navigation stack from a URL
 @param url the URL to match to a view controller to be pushed onto the navigation stack
 @discussion the navigationMap property MUST be valid to function correctly
 */
- (void) pushViewControllerWithURL:(NSURL*)url animated:(BOOL)animated;

@end
