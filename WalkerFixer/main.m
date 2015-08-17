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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        NSString *dir = [NSString stringWithFormat:@"%@/Desktop/yemeksepeti_ios/yemeksepeti/YemeksepetiApi/", NSHomeDirectory()];
//        NSDirectoryEnumerator *de = [[NSFileManager defaultManager] enumeratorAtPath:dir];
//        
//        WalkerFixer *fixer = [[WalkerFixer alloc] init];
//
//        for (NSString *file in de)
//            if ([[file pathExtension] isEqualToString:@"swift"])
//                [fixer fixFileWithMainDirectory:dir andFileDirectory:file];
        
        
        NSString *line1 = @"var someString: String?";
        NSString *line2 = @"var someInt    : Int?";
        NSString *line3 = @"var someNum  : String    = 3";
        
        NSLog(@"%@\n%@\n%@",
          [[WFProperty alloc] initWithLine:line1],
          [[WFProperty alloc] initWithLine:line2],
          [[WFProperty alloc] initWithLine:line3]);
    }
    
    return 0;
    
}
