//
//  WFClass.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import "WFClass.h"
#import "WFProperty.h"

@implementation WFClass

#pragma mark - Init

- (instancetype)initWithMainDirectory:(NSString *)main andFileDirectory:(NSString *)file {
    
    if ((self = [super init])) {
    
        self.mainDirectory = main;
        self.fileDirectory = file;
        
        NSString *file = [self readFile:[self mainDirectory]];
        
    }
    
    return self;
}


#pragma mark - Directory

- (NSString *)originalFilePath {
    return [NSString stringWithFormat:@"%@/%@", self.mainDirectory, self.fileDirectory];
}

- (NSString *)fixFilePath {
    return [NSString stringWithFormat:@"%@/fix/%@", self.mainDirectory, self.fileDirectory];
}


#pragma mark - Read

- (NSString *)readFile:(NSString *)path {
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
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
    return [NSString stringWithFormat:@"class %@: Mappable {", self.name];
}

- (NSString *)writeInit {
    return [NSString stringWithFormat:@"\n\toverride class func newInstance(map: Map) -> Mappable? {\n\t\treturn %@()\n\t}\n", self.name];
}

- (NSString *)writeMapperFunc {
    
    NSString *func = @"\n\toverride func mapping(map: Map) {\n";
    
    for (WFProperty *prop in self.properties) {
        func = [func stringByAppendingFormat:@"\t%@ <- map[\"%@\"]\n", prop.name, prop.name];
    }

    func = [func stringByAppendingString:@"\n\t}"];
    return func;
}

- (NSString *)writeFooter {
    return @"\n}";
}


#pragma mark - Save

- (void)save {
    
    NSString *new = [self write];
    NSString *savePath = [self fixFilePath];
    [[NSFileManager defaultManager] createDirectoryAtPath:[savePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];

    [new writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
