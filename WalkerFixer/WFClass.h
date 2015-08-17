//
//  WFClass.h
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFClass : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *properties;

- (instancetype)initWithLine:(NSString *)line;

- (NSString *)write;
- (void)save;

@end
