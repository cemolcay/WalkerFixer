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

@property (nonatomic, strong) NSString *mainDirectory;
@property (nonatomic, strong) NSString *fileDirectory;

- (instancetype)initWithMainDirectory:(NSString *)main andFileDirectory:(NSString *)file;

- (NSString *)write;
- (void)save;

- (NSString *)originalFilePath;
- (NSString *)fixFilePath;

- (void)detectClass;
- (void)detectProperties;

@end
