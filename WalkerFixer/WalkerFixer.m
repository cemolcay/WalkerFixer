//
//  WalkerFixer.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import "WalkerFixer.h"

@implementation WalkerFixer

- (void)fixFile:(NSString *)filePath {
    
    NSLog(@"%@", [self readFile:filePath]);
    
}

- (NSString *)readFile:(NSString *)path {
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

- (NSArray *)getClasses:(NSString *)file {
    return @[];
}

@end
