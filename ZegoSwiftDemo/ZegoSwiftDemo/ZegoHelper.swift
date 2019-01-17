//
//  ZegoHelper.swift
//  ZegoSwiftDemo
//
//  Created by Sky on 2019/1/16.
//  Copyright © 2019 zego. All rights reserved.
//

import Foundation
import ZegoLiveRoom

struct ZegoHelper {
    static let user: ZegoUser = {
        let timestamp = Date().timeIntervalSince1970
        let userID = "\(Int(timestamp))"
        var user = ZegoUser()
        user.userId = userID
        user.userName = UIDevice.current.name
        return user
    }()
}
