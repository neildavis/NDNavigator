//
//  NSString+URLDecode.h
//
//  Created by Neil Davis on 19/07/2014.
//  Copyright (c) 2014 Neil Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLDecode)

- (NSString *)stringByDecodingURLFormat;
- (NSMutableDictionary *)dictionaryFromQueryComponents;

@end
