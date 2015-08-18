//
//  main.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WalkerFixer.h"
#import "WFProperty.h"
#import "WFClass.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *line1 = @"var someString: String?";
        NSString *line2 = @"var someInt    : Int?";
        NSString *line3 = @"var someInt : Int? = 4";
        
        WFProperty *prop1 = [[WFProperty alloc] initWithLine:line1];
        WFProperty *prop2 = [[WFProperty alloc] initWithLine:line2];
        WFProperty *prop3 = [[WFProperty alloc] initWithLine:line3];
        
        NSString *mainDir = [NSString stringWithFormat:@"%@/Desktop/yemeksepeti_ios/yemeksepeti/YemeksepetiApi/", NSHomeDirectory()];
        NSString *fileDir = @"BaseApi/YSRequest.swift";
        
        WFClass *wf = [[WFClass alloc] initWithMainDirectory:mainDir andFileDirectory:fileDir];
        [wf setName:@"FixRequest"];
        [wf setProperties:@[prop1, prop2, prop3]];
        
        [wf save];
    }
    
    return 0;
    
}


void testWalkerFixer () {
    NSString *dir = [NSString stringWithFormat:@"%@/Desktop/yemeksepeti_ios/yemeksepeti/YemeksepetiApi/", NSHomeDirectory()];
    NSDirectoryEnumerator *de = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    
    WalkerFixer *fixer = [[WalkerFixer alloc] init];
    
    for (NSString *file in de)
        if ([[file pathExtension] isEqualToString:@"swift"])
            [fixer fixFileWithMainDirectory:dir andFileDirectory:file];
}

void testWFProperty () {
    NSString *line1 = @"var someString: String?";
    NSString *line2 = @"var someInt    : Int?";
    NSString *line3 = @"var someNum  : String    = 3";
    
    NSLog(@"%@\n%@\n%@",
          [[WFProperty alloc] initWithLine:line1],
          [[WFProperty alloc] initWithLine:line2],
          [[WFProperty alloc] initWithLine:line3]);
}

void testWFClass () {

    NSString *line1 = @"var someString: String?";
    NSString *line2 = @"var someInt    : Int?";

    WFProperty *prop1 = [[WFProperty alloc] initWithLine:line1];
    WFProperty *prop2 = [[WFProperty alloc] initWithLine:line2];

    NSString *mainDir = [NSString stringWithFormat:@"%@/Desktop/yemeksepeti_ios/yemeksepeti/YemeksepetiApi/", NSHomeDirectory()];
    NSString *fileDir = @"BaseApi/YSRequest.swift";
    
    WFClass *wf = [[WFClass alloc] initWithMainDirectory:mainDir andFileDirectory:fileDir];
    [wf setName:@"FixRequest"];
    [wf setProperties:@[prop1, prop2]];
    
    [wf save];
}