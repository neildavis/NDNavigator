//
//  NDNavigationMap.h
//
//  Created by Neil Davis on 19/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Callback block to instantiate a view controller from a class. Indirection enables dependency injection/setup etc */
typedef id (^NDNavigationFactoryBlock)(Class);

/**
 NDNavigationMap provides the core mapping from URL to UIViewController classes
 */
@interface NDNavigationMap : NSObject

/** 
 Optional callback factory block to instantiate a UIViewController instance from a Class. Facilitates setup of dependencies etc
 @see NDNavigationFactoryBlock
 If not set, or the facroy block returns nil, NDNavigationMap will attempt to instantiate the view controller
 itself by calling initWithNibName:bundle:
 */
@property (nonatomic, strong) NDNavigationFactoryBlock factoryBlock;

/**
 Setup a mapping from the host part of a URL to a view controller class, with no path parameters
 @param host the RFC1808 host of a URL to be mapped to a UIViewController subclass
 @param viewControllerClass The subclass of UIViewController to instantiate from URLs matching host
 */
- (void) mapFromHost:(NSString*)host toViewController:(Class)viewControllerClass;

/**
 Setup a mapping from the host part of a URL to a view controller class, including path parameters
 @param host the RFC1808 host of a URL to be mapped to a UIViewController subclass
 @param viewControllerClass The subclass of UIViewController to instantiate from URLs matching host
 @param pathPatern A SOCkit style pattern to match parameters in the RFC1808 path of a URL. @see SOCPAttern.
 @param selector A selector to be called on the instantiated view controller, passing the arguments matched from pathPatern. 
 @discussion selctor should contain at least as many arguments as tokens to be matched in pathPattern. When using path patterns, SOCkit takes care of
 converting the matched parameters in a URL path into the correct types to call selector
 */
- (void) mapFromHost:(NSString*)host toViewController:(Class)viewControllerClass withPathPattern:(NSString*)pathPatern willNavigateSelector:(SEL)selector;

/**
 Instantiates, configures and returns a view controller instance matching a URL
 @param url the URL to match to a UIViewContoller instance
 @return A UIViewController instance, or nil if no match can be found
 @discussion. If the viewcontroller was matched with path parameters, the appropriate selector will be called before returning
 If the mapped view controller class implements willNavigateWithPathParameters:queryParameters: it too will be called before returning. 
 @see UIViewController(NDNavigator)
 Any view controller objects instantiated by NDNavigationMap will also have their navigationMap extension property set before returning
 */
- (id) viewControllerForURL:(NSURL*)url;

@end
