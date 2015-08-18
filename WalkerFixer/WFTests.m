//
//  WFTests.m
//  
//
//  Created by Cem Olcay on 18/08/15.
//
//

#import "WFTests.h"
#import "WalkerFixer.h"
#import "WFClass.h"
#import "WFProperty.h"

@implementation WFTests

- (void)testFixLogin {
    
    NSString *dir = [NSString stringWithFormat:@"%@/Desktop/yemeksepeti_ios/yemeksepeti/YemeksepetiApi/OAuthLoginApi", NSHomeDirectory()];
    NSDirectoryEnumerator *de = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    
    WalkerFixer *fixer = [[WalkerFixer alloc] init];
    
    for (NSString *file in de)
        if ([[file pathExtension] isEqualToString:@"swift"])
            [fixer fixFileWithMainDirectory:dir andFileDirectory:file];
}

- (void)testWalkerFixer {
    
    NSString *dir = [NSString stringWithFormat:@"%@/Desktop/yemeksepeti_ios/yemeksepeti/YemeksepetiApi/", NSHomeDirectory()];
    NSDirectoryEnumerator *de = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    
    WalkerFixer *fixer = [[WalkerFixer alloc] init];
    
    for (NSString *file in de)
        if ([[file pathExtension] isEqualToString:@"swift"])
            [fixer fixFileWithMainDirectory:dir andFileDirectory:file];
}

- (void)testWFProperty {
    
    NSString *line1 = @"var someString: String?";
    NSString *line2 = @"var someInt    : Int?";
    NSString *line3 = @"var someNum  : String    = 3";
    
    NSLog(@"%@\n%@\n%@",
          [[WFProperty alloc] initWithLine:line1],
          [[WFProperty alloc] initWithLine:line2],
          [[WFProperty alloc] initWithLine:line3]);
}

- (void)testWFClass {
    
    NSString *line1 = @"var someString: String?";
    NSString *line2 = @"var someInt    : Int?";
    NSString *line3 = @"var someInt : Int? = 4";
    
    WFProperty *prop1 = [[WFProperty alloc] initWithLine:line1];
    WFProperty *prop2 = [[WFProperty alloc] initWithLine:line2];
    WFProperty *prop3 = [[WFProperty alloc] initWithLine:line3];
    
    NSString *mainDir = [NSString stringWithFormat:@"%@/Desktop/yemeksepeti_ios/yemeksepeti/YemeksepetiApi/", NSHomeDirectory()];
    NSString *fileDir = @"LoginApi/LoginRequest.swift";
    
    WFClass *wf = [[WFClass alloc] initWithMainDirectory:mainDir andFileDirectory:fileDir];
    [wf setName:@"FixRequest"];
    [wf setProperties:@[prop1, prop2, prop3]];
    
    [wf save];
}

@end