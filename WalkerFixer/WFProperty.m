//
//  WFProperty.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import "WFProperty.h"

@implementation WFProperty

- (instancetype)initWithLine:(NSString *)line {
    
    if ((self = [super init])) {
        
        self.line = line;
        
        //var prop: type? = ""
        NSArray *comp = [line componentsSeparatedByString:@" "];
        self.name = [self removeLastCharacter:comp[1]];
        self.type = [self removeLastCharacter:comp[2]];
    }
    
    return self;
}

- (NSString *)removeLastCharacter:(NSString *)str {

    int len = 0;
    
    if ([str hasSuffix:@":"] || [str hasSuffix:@"?"]) {
        len = 1;
    }
    
    return [str substringToIndex:str.length-len];
}

@end
