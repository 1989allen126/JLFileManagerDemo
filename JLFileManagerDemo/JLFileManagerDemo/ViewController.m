//
//  ViewController.m
//  JLFileManagerDemo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"

#import "NSFileManager+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *dirPath = [NSFileManager getDocumentsPath];
    [NSFileManager removeItemAtPath:dirPath];
    
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    for(NSUInteger index = 0;index < 10;index ++)
    {
        dispatch_semaphore_signal(semaphore);
        NSString *fileName = [NSString stringWithFormat:@"%@-%ld.text",[NSDate date],index];
        [NSFileManager createFile:dirPath fileName:fileName];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
    NSArray *files = [NSFileManager getLocalFilesUnderDirectory:dirPath];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:files];
//    [array sortUsingSelector:@selector(compare:)];
    
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        
//        return result == NSOrderedDescending; // 升序
        
         return result == NSOrderedAscending; // 降序
    }];
    
    NSLog(@"files===:%@",sortedArray);
}



@end
