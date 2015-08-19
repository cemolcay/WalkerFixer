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

- (void)fixServiceCallsForFileAt:(NSString *)path fileName:(NSString *)fileName endpoint:(NSString *)endpoint {
    
    NSString *file = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"func(?s)(.*?)\\{" options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (error) {
        NSLog(@"regex error: %@", error.description);
        return;
    }
    
    NSLog(@"%lu matches", (unsigned long)[regex numberOfMatchesInString:file options:0 range:NSMakeRange(0, file.length)]);
    
    NSArray *matches = [regex matchesInString:file options:0 range:NSMakeRange(0, file.length)];
    NSString *fixedCalls = @"\n";
    for (NSTextCheckingResult *match in matches) {
        
        NSString *func = [file substringWithRange:[match rangeAtIndex:1]];
        NSString *fixed = [self fixFunc:func endpoint:endpoint];
        fixedCalls = [fixedCalls stringByAppendingFormat:@"%@\n", fixed];
    }
    
    NSString *savePath = [NSString stringWithFormat:@"%@/Desktop/Service/%@.swift", NSHomeDirectory(), fileName];
    [[NSFileManager defaultManager] createDirectoryAtPath:[savePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    
    [fixedCalls writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)fixFunc:(NSString *)func endpoint:(NSString *)end {
    
    // one line
    func = [[func componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    // remove whitespace
    func = [func stringByReplacingOccurrencesOfString:@" " withString:@""];
    // split
    NSArray *comp = [func componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"(:,-)"]];
    
    NSString *name = comp[0];
    
    NSString *nameFirst = [name substringToIndex:1];
    NSString *nameRest = [name substringFromIndex:1];
    NSString *endpoint = [NSString stringWithFormat:@"%@.%@%@", end, nameFirst.uppercaseString, nameRest];
    
    NSString *request = nil;
    NSString *response = nil;
    for (NSString *com in comp) {
        if ([com hasSuffix:@"Request"]) {
            request = com;
        } else if ([com hasSuffix:@"Response"]) {
            response = com;
        }
    }
    
    return [self newFuncWithName:name request:request response:response endpoint:endpoint];
}

- (NSString *)newFuncWithName:(NSString *)name request:(NSString *)request response:(NSString *)response endpoint:(NSString *)endpoint {
    
    NSString *requestLine = @"";
    if (request) {
        requestLine = [NSString stringWithFormat:@"request: %@,\n\t\t", request];
    }
    
    return [NSString stringWithFormat:@"\tfunc %@ (\n\t\t%@success: (%@) -> Void,\n\t\tfail: ((NSError) -> Void)? = nil) {\n\n\t\tself.request(%@,\n\t\t\trequest: %@,\n\t\t\tsuccess: success,\n\t\t\tfail: fail)\n\t}\n", name, requestLine, response, endpoint, request == nil ? @"ysRequest!" : @"request"];
}


@end
