//
//  LLNetworkManager.m
//  LLNetworkService
//
//  Created by 百里沉渊🐱 on 2018/8/16.
//  Copyright © 2018年 百里沉渊🐱. All rights reserved.
//

#import "LLNetworkManager.h"

//#import <AFNetworking.h>

@interface LLNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

static LLNetworkManager *_defaultManager;

@implementation LLNetworkManager

+ (LLNetworkManager *)setupDefaultManagerWithBaseUrl:(NSString *)baseUrl {
    
    LLNetworkManager *manager = [[LLNetworkManager alloc]init];
    manager.baseUrl = baseUrl;
    manager.sessionManager = [AFHTTPSessionManager manager];
    
    return manager;
    
}

+ (LLNetworkManager *)defaultManager {
    
    if (_defaultManager == nil) {
        _defaultManager = [self setupDefaultManagerWithBaseUrl:nil];
    }
    
    return _defaultManager;
}

- (NSString *)fullUrlWithServer:(NSString *)serverUrl apiPath:(NSString *)apiPath {
    
    NSMutableString *fullUrl = [NSMutableString string];
    if (serverUrl.length > 0) {
        [fullUrl appendString:fullUrl];
        if ([fullUrl hasSuffix:@"/"]) {
            [fullUrl deleteCharactersInRange:NSMakeRange(fullUrl.length - 1, 1)];
        }
    }
    if (apiPath.length > 0) {
        if ([apiPath hasPrefix:@"/"]) {
            [fullUrl appendFormat:@"%@", apiPath];
        } else {
            [fullUrl appendFormat:@"/%@", apiPath];
        }
    }
    
    return fullUrl;
}

- (NSURLSessionDataTask *)get:(NSString *)serverUrl apiPath:(NSString *)apiPath parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))downloadProgress responseHandler:(LLNetworkResponseBlock)responseHandler {
    
    NSString *fullUrl = [self fullUrlWithServer:serverUrl apiPath:apiPath];
    
    NSURLSessionDataTask *dataTask = [self.sessionManager GET:fullUrl parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseHandler(task, nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(task, error, nil);
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)post:(NSString *)serverUrl apiPath:(NSString *)apiPath parameters:(NSDictionary *)parameters headers:(NSDictionary<NSString *,NSString *> *)headers progress:(void (^)(NSProgress *))uploadProgress responseHandler:(LLNetworkResponseBlock)responseHandler {
    
    NSString *fullUrl = [self fullUrlWithServer:serverUrl apiPath:apiPath];
    
    NSURLSessionDataTask *dataTask = [self.sessionManager POST:fullUrl parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseHandler(task, nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(task, error, nil);
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)upload:(NSString *)serverUrl apiPath:(NSString *)apiPath parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block progress:(void (^)(NSProgress *))uploadProgress responseHandler:(LLNetworkResponseBlock)responseHandler {
    
    NSString *fullUrl = [self fullUrlWithServer:serverUrl apiPath:apiPath];
    
    NSURLSessionDataTask *dataTask = [self.sessionManager POST:fullUrl parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseHandler(task, nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(task, error, nil);
    }];
    
    return dataTask;
}

@end
