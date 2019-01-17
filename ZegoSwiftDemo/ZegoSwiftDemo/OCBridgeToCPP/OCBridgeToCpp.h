//
//  OCBridgeToCpp.h
//  ZegoSwiftDemo
//
//  Created by Sky on 2019/1/16.
//  Copyright © 2019 zego. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZegoLiveRoomApi;

@interface OCBridgeToCpp : NSObject

- (void)api:(ZegoLiveRoomApi *)api enableAECWhenHeadsetDetected:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
