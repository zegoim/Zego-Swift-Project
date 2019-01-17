//
//  OCBridgeToCpp.m
//  ZegoSwiftDemo
//
//  Created by Sky on 2019/1/16.
//  Copyright © 2019 zego. All rights reserved.
//

#import "OCBridgeToCpp.h"
#import <ZegoLiveRoom/ZegoLiveRoomApi-AudioIO.h>

@implementation OCBridgeToCpp

- (void)api:(ZegoLiveRoomApi *)api enableAECWhenHeadsetDetected:(BOOL)enable {
    [api enableAECWhenHeadsetDetected:enable];
}

@end
