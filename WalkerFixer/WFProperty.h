//
//  WFProperty.h
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFProperty : NSObject

@property (nonatomic, strong) NSString *line;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;

- (instancetype)initWithLine:(NSString *)line;

@end
