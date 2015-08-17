//
//  WFClass.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import "WFClass.h"

@implementation WFClass

#pragma mark - Init

- (instancetype)initWithLine:(NSString *)line {
    
    if ((self = [super init])) {
    
        
    }
    
    return self;
}


#pragma mark - Write

- (NSString *)write {
    NSString *new = @"";
    new = [new stringByAppendingString:[self writeHeader]];
    new = [new stringByAppendingString:[self writeInit]];
    new = [new stringByAppendingString:[self writeMapperFunc]];
    return new;
}

- (NSString *)writeHeader {
    return @"";
}

- (NSString *)writeInit {
    return @"";
}

- (NSString *)writeMapperFunc {
    return @"";
}

- (NSString *)writeFooter {
    return @"";
}


#pragma mark - Save

- (void)save {
    
    NSString *new = [self write];
    //save
}

@end
