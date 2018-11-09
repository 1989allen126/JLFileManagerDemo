//
//  NSFileManager+Extension.h.m
//  JLFileManagerDemo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSFileManager+Extension.h"

@implementation NSFileManager (Extension)

// 获取沙盒根路径
+ (NSString *)getHomePath {
    
    return NSHomeDirectory();
}

// 获取tmp路径
+ (NSString *)getTmpPath {
    
    return NSTemporaryDirectory();
}

// 获取Documents路径
+ (NSString *)getDocumentsPath {
    
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArr firstObject];
    return path;
}

// 获取Library路径
+ (NSString *)getLibraryPath {
    
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArr firstObject];
    return path;
}

// 获取LibraryCache路径
+ (NSString *)getLibraryCachePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    return path;
}

// 检查文件、文件夹是否存在
+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDir {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:isDir];
    return exist;
}

// 创建路径
+ (void)createDirectory:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!isDir) {
        [fileManager removeItemAtPath:path error:nil];
        exist = NO;
    }
    if (!exist) {
        // 注：直接创建不会覆盖原文件夹
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

// 创建文件
+ (NSString *)createFile:(NSString *)filePath fileName:(NSString *)fileName {
    
    // 先创建路径
    [self createDirectory:filePath];
    
    // 再创建路径上的文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    BOOL isDir;
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (isDir) {
        [fileManager removeItemAtPath:path error:nil];
        exist = NO;
    }
    if (!exist) {
        // 注：直接创建会被覆盖原文件
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
}

// 复制 文件or文件夹
+ (void)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager copyItemAtPath:srcPath toPath:dstPath error:&error];
    if (!result && error) {
        NSLog(@"copyItem Error : %@", error.description);
    }
}

// 移动 文件or文件夹
+ (void)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager moveItemAtPath:srcPath toPath:dstPath error:&error];
    if (!result && error) {
        NSLog(@"moveItem Error : %@", error.description);
    }
}

// 删除 文件or文件夹
+ (void)removeItemAtPath:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager removeItemAtPath:path error:&error];
    if (!result && error) {
        NSLog(@"removeItem Error : %@", error.description);
    }
}

// 获取目录下所有内容
+ (NSArray *)getContentsOfDirectoryAtPath:(NSString *)docPath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *contentArr = [fileManager contentsOfDirectoryAtPath:docPath error:&error];
    if (!contentArr.count && error) {
        NSLog(@"ContentsOfDirectory Error : %@", error.description);
    }
    return contentArr;
}


//移除所有文件
+ (void)removeAllFilesAtDirectory:(NSString *)dirPath {
    
    if(!dirPath){
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL exist = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    if(!isDir || !exist)
    {
        return ;
    }
    
    //删除目录下的所有文件
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    for (NSString *fileName in enumerator) {
        [[NSFileManager defaultManager] removeItemAtPath:[dirPath stringByAppendingPathComponent:fileName] error:nil];
    }
}

//获取目录下的所有文件
+ (NSArray*)getLocalFilesUnderDirectory:(NSString *)dirPath {
    
    NSMutableArray *filesPaths = [NSMutableArray array];
    if(!dirPath){
        return filesPaths;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL exist = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    if(!isDir || !exist)
    {
        return filesPaths;
    }
    
    //删除目录下的所有文件
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    NSString *fileName;
    while (fileName = [enumerator nextObject]) {
        NSString *fullPath = [dirPath stringByAppendingPathComponent:fileName];
        [filesPaths addObject:fullPath];
    }
    
    return filesPaths;
}
@end
