//
//  NDSimpleViewControllerFactory.m
//  NDNavigatorExample
//
//  Created by Neil Davis on 20/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "NDSimpleViewControllerFactory.h"

#import "NDRootViewController.h"
#import "NDBlueViewController.h"
#import "NDGreenViewController.h"


@implementation NDSimpleViewControllerFactory

- (id) viewControllerForClass:(Class)clazz
{
    // Naive implementation for demo purposes
    if ([clazz isSubclassOfClass:[NDRootViewController class]])
    {
        return [self rootViewController];
    }
    if ([clazz isSubclassOfClass:[NDBlueViewController class]])
    {
        return [self blueViewController];
    }
    if ([clazz isSubclassOfClass:[NDGreenViewController class]])
    {
        return [self greenViewController];
    }
    return  nil;
}

- (id) rootViewController
{
    return [[NDRootViewController alloc] initWithNibName:@"NDRootViewController" bundle:[NSBundle mainBundle]];
}

- (id) blueViewController
{
    return [[NDBlueViewController alloc] initWithNibName:@"NDBlueViewController" bundle:[NSBundle mainBundle]];
}

- (id) greenViewController
{
    return [[NDGreenViewController alloc] initWithNibName:nil bundle:nil];
}

@end
