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
        self.NSCodingEnabled = NO;
        
        NSString *file = [self readFile:[self originalFilePath]];
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

    file = [file stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *lines = [file componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray *tempProps = [[NSMutableArray alloc] init];
    
    for (NSString *line in lines) {
        
        NSString *className = [self detectClass:line];
        WFProperty *prop = [self detectProperty:line];
        
        if (className) {
            self.name = className;
        }
        
        if (prop) {
            [tempProps addObject:prop];
        }
        
        self.NSCodingEnabled = self.NSCodingEnabled || [self detectNSCoding:line];
    }
    
    self.properties = [tempProps mutableCopy];
}

- (NSString *)detectClass:(NSString *)line {
    
    if ([line hasPrefix:@"class"]) {
        NSString *nonclass = [line substringFromIndex:5];
        NSArray *comp = [nonclass componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":{"]];
        return comp[0];
    }
    
    return nil;
}

- (WFProperty *)detectProperty:(NSString *)line {
    
    if ([line hasPrefix:@"var"]) {
        return [[WFProperty alloc] initWithLine:line];
    }
    
    return nil;
}

- (BOOL)detectNSCoding:(NSString *)line {
    return [line containsString:@"encodeWithCoder"];
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
    new = [new stringByAppendingString:[self writeNSCoding]];
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
    header = [header stringByAppendingString:@"\n\nimport Foundation\nimport ObjectMapper"];
    return [NSString stringWithFormat:@"%@\n\nclass %@: YSObject%@ {", header, self.name, self.NSCodingEnabled ? @", NSCoding" : @""];
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

- (NSString *)writeNSCoding {
    
    if (!self.NSCodingEnabled) {
        return @"";
    }
    
    NSString *coding = @"\n\n\t// MARK: NSCoding\n\n";
    
    // coder

    coding = [coding stringByAppendingString:@"\t@objc required init (coder aDecoder: NSCoder) {\n\t\tsuper.init()\n\n"];
    
    for (WFProperty *prop in self.properties) {
        coding = [coding stringByAppendingFormat:@"\t\t%@\n", [prop decodeLine]];
    }
    
    coding = [coding stringByAppendingString:@"\t}\n\n"];
    
    
    // decoder
    
    coding = [coding stringByAppendingString:@"\t@objc func encodeWithCoder(aCoder: NSCoder) {\n"];
    
    for (WFProperty *prop in self.properties) {
        coding = [coding stringByAppendingFormat:@"\t\t%@\n", [prop encodeLine]];
    }
    
    coding = [coding stringByAppendingString:@"\t}\n"];

    return coding;
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
