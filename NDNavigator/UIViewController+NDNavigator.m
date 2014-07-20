//
//  UIViewController+NDNavigator.m
//
//  Created by Neil Davis on 19/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "UIViewController+NDNavigator.h"
#import "NDNavigationMap.h"
#import "objc/runtime.h"

@implementation UIViewController (NDNavigator)

static char kNavigationMapKey;

- (NDNavigationMap*)navigationMap
{
    NDNavigationMap *navMap = objc_getAssociatedObject(self, &kNavigationMapKey);
    return navMap;
}

- (void) setNavigationMap:(NDNavigationMap *)navigationMap
{
    objc_setAssociatedObject(self, &kNavigationMapKey, navigationMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) willNavigateWithPathParamaters:(NSDictionary*)pathParams queryParameters:(NSDictionary*)queryParams
{
    
}

- (void) presentViewControllerWithURL:(NSURL*)url animated:(BOOL)flag config:(void (^)(UIViewController*))config completion:(void (^)(void))completion
{
    UIViewController *vc = [self.navigationMap viewControllerForURL:url];
    if (vc)
    {
        if (config)
        {
            // Callback to allow client to configure the presented VC, modal transition/presentation styles etc
            config(vc);
        }
        [self presentViewController:vc animated:flag completion:completion];
    }
    
}

@end
