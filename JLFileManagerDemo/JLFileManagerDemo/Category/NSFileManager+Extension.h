//
//  NSFileManager+Extension.h
//  JLFileManagerDemo
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Extension)

/**
 获取沙盒根路径

 @return 文件路径
 */
+ (NSString *)getHomePath;


/**
 获取tmp路径

 @return tmp文件路径
 */
+ (NSString *)getTmpPath;


/**
 获取Documents路径

 @return Documents路径
 */
+ (NSString *)getDocumentsPath;


/**
 获取Library路径

 @return Library路径
 */
+ (NSString *)getLibraryPath;



/**
 获取LibraryCache路径
 
 @return LibraryCache路径
 */
+ (NSString *)getLibraryCachePath;


/**
 检查文件、文件夹是否存在

 @param path  文件路径
 @param isDir 是否为目录
 @return 判断文件、文件夹是否存在
 */
+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDir;


/**
 创建文件目录

 @param path 目录路径
 */
+ (void)createDirectory:(NSString *)path;



/**
 创建文件夹

 @param filePath 目录路径(如果文件目录不存在,先创建目录)
 @param fileName 文件名
 @return 创建成功的文件路径
 */
+ (NSString *)createFile:(NSString *)filePath fileName:(NSString *)fileName;


/**
  复制 文件or文件夹

 @param srcPath 源文件或者m文件夹的路径
 @param dstPath 目标路径
 */
+ (void)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;


/**
 移动 文件or文件夹
 
 @param srcPath 源文件或者m文件夹的路径
 @param dstPath 目标路径
 */
+ (void)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;


/**
 删除 文件or文件夹
 
 @param path 文件或者文件夹所在路径
 */
+ (void)removeItemAtPath:(NSString *)path;


/**
 获取目录下所有内容
 
 @param docPath 文件夹所在路径
 */
+ (NSArray *)getContentsOfDirectoryAtPath:(NSString *)docPath;



/**
 删除目录下的所有文件(保留目录名)

 @param dirPath 目录名
 */
+(void)removeAllFilesAtDirectory:(NSString *)dirPath;



/**
 获取目录下的所有文件

 @param dirPath 目录名
 @return 文件数组
 */
+(NSArray*)getLocalFilesUnderDirectory:(NSString *)dirPath;
    
@end

NS_ASSUME_NONNULL_END
