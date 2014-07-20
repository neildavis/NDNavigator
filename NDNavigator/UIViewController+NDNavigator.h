//
//  UIViewController+NDNavigator.h
//
//  Created by Neil Davis on 19/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NDNavigationMap;

@interface UIViewController (NDNavigator)

/** Access to the NDNavigationMap. Automatically set on instqnces created by NDNavigationMap */
@property (nonatomic, strong) NDNavigationMap *navigationMap;

/**
 This method is called by NDNavigationMap when a view controller is matched to a URL
 @param pathParams. A dictionary containing the parameters matched by the SOCPattern from the URL path. Nil if no path paramters were matched
 @param queryParameters. A dictionary of NSString->NSArray containg the URL query string paramters
 */
- (void) willNavigateWithPathParamaters:(NSDictionary*)pathParams queryParameters:(NSDictionary*)queryParams;

/**
 Helper utility to present a view controller from a URL
 @param url the URL to match to a view controller to be presented
 @param animated flag to determine if the presentation is perfromed using an animation
 @param config a callback block passing  the matched view controller instance. Allows setup of modal presentation/transition style etc before the vc is presented
 @param completion a block that is called when the view controller is presented, after animation if specified.
 @discussion the navigationMap property MUST be valid to function correctly
 */
- (void) presentViewControllerWithURL:(NSURL*)url animated:(BOOL)flag config:(void (^)(UIViewController*))config completion:(void (^)(void))completion;

@end
