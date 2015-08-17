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
        
        NSString *nonWhite = [self removeWhitespaces:line];
        NSString *nonVar = [nonWhite substringFromIndex:3];
        
        NSArray *comp = [nonVar componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":="]];
        self.name = [self removeLastCharacter:comp[0]];
        self.type = [self removeLastCharacter:comp[1]];
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

- (NSString *)removeWhitespaces:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)fixedLine {
    return [NSString stringWithFormat:@"\t%@ <- map[\"%@\"]\n", self.name, self.name];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"|%@|: |%@|", self.name, self.type];
}

@end
