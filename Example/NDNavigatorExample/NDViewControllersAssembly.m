//
//  NDViewControllersAssembly.m
//  NDNavigatorExample
//
//  Created by Neil Davis on 20/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "NDViewControllersAssembly.h"
#import "TyphoonDefinition.h"

#import "NDRootViewController.h"
#import "NDBlueViewController.h"
#import "NDGreenViewController.h"

@implementation NDViewControllersAssembly

- (id) rootViewController
{
    return [TyphoonDefinition withClass:[NDRootViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithNibName:bundle:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"NDRootViewController"];
            [initializer injectParameterWith:[NSBundle mainBundle]];
        }];
    }];
}

- (id) blueViewController
{
    return [TyphoonDefinition withClass:[NDBlueViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithNibName:bundle:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"NDBlueViewController"];
            [initializer injectParameterWith:[NSBundle mainBundle]];
        }];
    }];
}

- (id) greenViewController
{
    return [TyphoonDefinition withClass:[NDGreenViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithNibName:bundle:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:nil];
            [initializer injectParameterWith:nil];
        }];
    }];
}

@end
