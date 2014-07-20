//
//  NDNavigationMap.m
//
//  Created by Neil Davis on 19/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import "NDNavigationMap.h"
#import "UIViewController+NDNavigator.h"
#import "NSString+URLDecode.h"
#import "SOCKit.h"

@interface NDNavigationMapEntry : NSObject

+ (instancetype) entryWithClass:(Class)class pathPattern:(SOCPattern*)pathPattern willNavigateSelector:(SEL)selector;
@property (nonatomic, weak) Class class;
@property (nonatomic, strong) SOCPattern *pathPattern;
@property (nonatomic, assign) SEL willNavigateSelector;

@end

@interface NDNavigationMap ()

@property (nonatomic, strong) NSMutableDictionary *hostEntryMap;

@end

@implementation NDNavigationMap

- (void) mapFromHost:(NSString*)host toViewController:(Class)viewControllerClass
{
    [self mapFromHost:host toViewController:viewControllerClass withPathPattern:nil willNavigateSelector:nil];
}

- (void) mapFromHost:(NSString*)host toViewController:(Class)viewControllerClass withPathPattern:(NSString*)pathPatern willNavigateSelector:(SEL)selector
{
    if (![viewControllerClass isSubclassOfClass:[UIViewController class]])
    {
        [NSException raise:NSInvalidArgumentException format:@"%@ is not a sublcass of UIViewController", NSStringFromClass(viewControllerClass)];
    }
    SOCPattern *socPathPattern = (pathPatern && pathPatern.length > 0) ? [SOCPattern patternWithString:pathPatern] : nil;
    [[self entriesForHost:host] addObject:[NDNavigationMapEntry entryWithClass:viewControllerClass pathPattern:socPathPattern willNavigateSelector:selector]];
}

- (id) viewControllerForURL:(NSURL*)url
{
    NDNavigationMapEntry *entry = [self matchingEntryForURL:url];
    if (entry)
    {
        id vc = [self viewControllerInstanceForClass:entry.class];
        if (vc)
        {
            NSString *path = url.path;
            if (entry.willNavigateSelector && [vc respondsToSelector:entry.willNavigateSelector])
            {
                // VC implments entry.willNavigateSelector - call it with path params
                [entry.pathPattern performSelector:entry.willNavigateSelector onObject:vc sourceString:path];
            }
            if ([vc respondsToSelector:@selector(willNavigateWithPathParameters:queryParameters:)])
            {
                // VC implements UIViewController+NDNavigator.h - call willNavigateWithPathParameters:queryParameters:
                NSDictionary *pathParams = (path && entry.pathPattern) ? [entry.pathPattern parameterDictionaryFromSourceString:path]: nil;
                NSDictionary *queryParams = [url.query dictionaryFromQueryComponents];
                [vc willNavigateWithPathParameters:pathParams queryParameters:queryParams];
            }
            
            return vc;
        }
    }
    return nil;
}

#pragma mark - NSObject overrides

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _hostEntryMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Private methods

- (NSMutableArray*) entriesForHost:(NSString*)host
{
    NSMutableArray *entries = _hostEntryMap[host];
    if (!entries)
    {
        entries = [[NSMutableArray alloc] init];
        _hostEntryMap[host] = entries;
    }
    return entries;
}

- (NDNavigationMapEntry*) matchingEntryForURL:(NSURL*)url
{
    NSArray *entriesForHost = [[self entriesForHost:url.host] copy];
    NSArray *pathComponents = url.pathComponents;
    BOOL pathExists = (pathComponents.count > 1);   // pathComponents always includes @"/" as fist object
    if (entriesForHost.count > 0)
    {
        NSMutableArray *candidates = [[NSMutableArray alloc] initWithCapacity:entriesForHost.count];
        for (NDNavigationMapEntry *entry in entriesForHost)
        {
            if (!pathExists && !entry.pathPattern)
            {
                // No path in url or entry pattern matches
                [candidates addObject:entry];
            }
            else if (pathExists && [entry.pathPattern stringMatches:url.path])
            {
                // path in url matches path in pattern
                [candidates addObject:entry];
            }
        }
        
        if (candidates.count > 1)
        {
            [NSException raise:NSInternalInconsistencyException format:@"multiple potential matches for url=%@, matches=%@", url, candidates];
        }
        return [candidates firstObject];
    }
    return nil;
}

- (id) viewControllerInstanceForClass:(Class)class
{
    id instance = nil;
    if (self.factoryBlock)
    {
        // Use a facotry if supplied
        instance = self.factoryBlock(class);
    }
    if (!instance)
    {
        // No factory, or factory can't provide an instance. Try to load from NIB in main bundle
        if ([class isSubclassOfClass:[UIViewController class]])
        {
            NSString *nibName = NSStringFromClass(class);
            if ([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"])
            {
                // Found a matching NIB
                instance = [[class alloc] initWithNibName:nibName bundle:[NSBundle mainBundle]];
            }
            else
            {
                // No matching NIB, alloc & init
                instance = [[class alloc] initWithNibName:nil bundle:nil];
            }
        }
    }
    if (instance && [instance isKindOfClass:[UIViewController class]])
    {
        // Add navigation map access to UIViewController instance
        ((UIViewController*)instance).navigationMap = self;
    }
    return instance;
}

@end

@implementation NDNavigationMapEntry

+ (instancetype) entryWithClass:(Class)class pathPattern:(SOCPattern*)pathPattern willNavigateSelector:(SEL)selector
{
    return [[[self class] alloc] initWithClass:class pathPattern:pathPattern willNavigateSelector:selector];
}

- (instancetype) initWithClass:(Class)class pathPattern:(SOCPattern*)pathPattern willNavigateSelector:(SEL)selector
{
    self = [super init];
    if (self)
    {
        self.class = class;
        self.pathPattern = pathPattern;
        self.willNavigateSelector = selector;
    }
    return self;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"class=%@, pattern=%@, willNavigateSelector=%@", NSStringFromClass(self.class), self.pathPattern, NSStringFromSelector(self.willNavigateSelector)];
}

@end


