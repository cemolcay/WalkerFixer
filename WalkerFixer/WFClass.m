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
        [self detect:file];
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


#pragma mark - Detection

- (void)detect:(NSString *)file {

}

- (void)detectClass {

}

- (void)detectProperties {

}


#pragma mark - Read

- (NSString *)readFile:(NSString *)path {
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}


#pragma mark - Write

- (NSString *)write {
    NSString *new = @"";
    new = [new stringByAppendingString:[self writeHeader]];
    new = [new stringByAppendingString:[self writeProperties]];
    new = [new stringByAppendingString:[self writeInit]];
    new = [new stringByAppendingString:[self writeMapperFunc]];
    new = [new stringByAppendingString:[self writeFooter]];
    return new;
}

- (NSString *)writeHeader {
    
    NSString *infoHeader =
@"//                                                    \n\
//  %@.swift                                            \n\
//  YSWebServices                                       \n\
//                                                      \n\
//  Created by Cem Olcay on 17/08/15.                   \n\
//  Copyright (c) 2015 yemeksepeti. All rights reserved.\n\
//                                                      \n\
//  Created with WalkerFixer                            \n\
//  http://www.github.com/cemolcay/WalkerFixer          \n\
//";
    
    NSString *header = [NSString stringWithFormat:infoHeader, self.name];
    
    return [NSString stringWithFormat:@"%@\n\nclass %@: Mappable {", header, self.name];
}

- (NSString *)writeProperties {
    
    NSString *props = @"\n";
    
    for (WFProperty *prop in self.properties) {
        props = [props stringByAppendingString:[prop fixedPropertyLine]];
    }
    
    return props;
}

- (NSString *)writeInit {
    return [NSString stringWithFormat:@"\n\n\toverride class func newInstance(map: Map) -> Mappable? {\n\t\treturn %@()\n\t}\n", self.name];
}

- (NSString *)writeMapperFunc {
    
    NSString *func = @"\n\toverride func mapping(map: Map) {\n";
    func = [func stringByAppendingFormat:@"\t\tsuper.mapping(map)\n\n"];
    
    for (WFProperty *prop in self.properties) {
        func = [func stringByAppendingString:[prop fixedMappingLine]];
    }

    func = [func stringByAppendingString:@"\t}"];
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
