//
//  main.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WalkerFixer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *dir = [NSString stringWithFormat:@"%@/Desktop/yemeksepeti_ios/yemeksepeti/YemeksepetiApi/", NSHomeDirectory()];
        NSDirectoryEnumerator *de = [[NSFileManager defaultManager] enumeratorAtPath:dir];
        
        WalkerFixer *fixer = [[WalkerFixer alloc] init];

        for (NSString *file in de)
            if ([[file pathExtension] isEqualToString:@"swift"])
                [fixer fixFileWithMainDirectory:dir andFileDirectory:file];
        
    }
    
    return 0;
    
}
