//
//  WFProperty.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import "WFProperty.h"

@implementation WFProperty

#pragma mark - Init

- (instancetype)initWithLine:(NSString *)line {
    
    if ((self = [super init])) {
        
        // var propName: Type = "value"
        
        self.line = line;
        
        NSString *nonWhite = [self removeWhitespaces:line];
        NSString *nonVar = [nonWhite substringFromIndex:3];
        
        NSArray *comp = [nonVar componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":=/"]];
        self.name = [self removeLastCharacter:comp[0]];
        self.type = [self removeLastCharacter:comp[1]];

        @try {
            self.value = comp[2];
        }
        @catch (NSException *exception) {
            NSLog(@"no comp[2]");
        }
    }
    
    return self;
}


#pragma mark - Helpers

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


#pragma mark - Generators

- (NSString *)fixedPropertyLine {
    return [NSString stringWithFormat:@"\n\tvar %@: %@? %@", self.name, self.type, self.value != nil ? [NSString stringWithFormat:@"= %@", self.value] : @""];
}

- (NSString *)fixedMappingLine {
    return [NSString stringWithFormat:@"\t\t%@ <- map[\"%@\"]\n", self.name, self.name];
}


- (NSString *)encodeLine {
    
    if ([self.type isEqualToString:@"Int"]) {
        return [NSString stringWithFormat:@"aCoder.encodeInteger(%@, forKey: \"%@\")", self.name, self.name];
    } else if ([self.type isEqualToString:@"Float"]) {
        return [NSString stringWithFormat:@"aCoder.encodeFloat(%@, forKey: \"%@\")", self.name, self.name];
    } else {
        return [NSString stringWithFormat:@"aCoder.encodeObject(%@, forKey: \"%@\")", self.name, self.name];
    }
}

- (NSString *)decodeLine {
    
    if ([self.type isEqualToString:@"Int"]) {
        return [NSString stringWithFormat:@"%@ = aDecoder.decodeIntegerForKey(\"%@\")", self.name, self.name];
    } else if ([self.type isEqualToString:@"Float"]) {
        return [NSString stringWithFormat:@"%@ = aDecoder.decodeFloatForKey(\"%@\")", self.name, self.name];
    } else {
        return [NSString stringWithFormat:@"%@ = aDecoder.decodeObjectForKey(\"%@\") as? %@", self.name, self.name, self.type];
    }
}

#pragma mark - Description

- (NSString *)description {
    return [NSString stringWithFormat:@"|%@|: |%@|", self.name, self.type];
}

@end
