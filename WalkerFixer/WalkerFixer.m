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

@end
