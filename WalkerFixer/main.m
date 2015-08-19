//
//  main.m
//  WalkerFixer
//
//  Created by Cem Olcay on 17/08/15.
//  Copyright (c) 2015 prototapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WalkerFixer.h"
#import "WFTests.h"
#import "WFProperty.h"
#import "WFClass.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        WFTests *tester = [[WFTests alloc] init];
        [tester testServiceCalls];
    }
    
    return 0;
}
