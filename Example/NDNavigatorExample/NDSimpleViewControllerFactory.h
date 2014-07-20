//
//  NDSimpleViewControllerFactory.h
//  NDNavigatorExample
//
//  Created by Neil Davis on 20/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDSimpleViewControllerFactory : NSObject

- (id) viewControllerForClass:(Class)clazz;

- (id) rootViewController;
- (id) blueViewController;
- (id) greenViewController;

@end
