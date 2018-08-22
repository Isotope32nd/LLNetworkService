//
//  LLNetworkManager.h
//  LLNetworkService
//
//  Created by 百里沉渊🐱 on 2018/8/16.
//  Copyright © 2018年 百里沉渊🐱. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LLNetworkResponseBlock)(NSURLSessionDataTask *task, NSError *error, id responseObject);

@interface LLNetworkManager : NSObject

@property (nonatomic, copy) NSString *baseUrl;

+ (LLNetworkManager *)defaultManager;

+ (LLNetworkManager *)setupDefaultManagerWithBaseUrl:(NSString *)baseUrl;

- (NSString *)fullUrlWithServer:(NSString *)serverUrl apiPath:(NSString *)apiPath;

- (NSURLSessionDataTask *)get:(NSString *)serverUrl apiPath:(NSString *)apiPath parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))downloadProgress responseHandler:(LLNetworkResponseBlock)responseHandler;

- (NSURLSessionDataTask *)post:(NSString *)serverUrl apiPath:(NSString *)apiPath parameters:(NSDictionary *)parameters headers:(NSDictionary<NSString *, NSString *> *)headers progress:(void (^)(NSProgress *))uploadProgress responseHandler:(LLNetworkResponseBlock)responseHandler;

@end
