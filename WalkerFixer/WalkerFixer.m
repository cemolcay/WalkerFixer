//
//  WalkerFixer.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import "WalkerFixer.h"
#import "WFClass.h"

@implementation WalkerFixer

- (void)fixFileWithMainDirectory:(NSString *)mainDirectory andFileDirectory:(NSString *)fileDirectory {
    WFClass *fix = [[WFClass alloc] initWithMainDirectory:mainDirectory andFileDirectory:fileDirectory];
    [fix save];
}

- (void)fixServiceCallsForFileAt:(NSString *)path {
    
    NSString *file = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"func(?s)(.*?)\\{" options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (error) {
        NSLog(@"regex error: %@", error.description);
        return;
    }
    
    NSLog(@"%lu matches", (unsigned long)[regex numberOfMatchesInString:file options:0 range:NSMakeRange(0, file.length)]);
    
    NSArray *matches = [regex matchesInString:file options:0 range:NSMakeRange(0, file.length)];
    
    for (NSTextCheckingResult *match in matches) {
        NSLog(@"\nmatch:\n%@", [file substringWithRange:[match rangeAtIndex:1]]);
    }
}

@end
