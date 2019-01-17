//
//  ZegoAnchorViewController.swift
//  ZegoSwiftDemo
//
//  Created by Sky on 2019/1/16.
//  Copyright © 2019 zego. All rights reserved.
//

import UIKit
import ZegoLiveRoom

class ZegoAnchorViewController: UIViewController {
    
    lazy var api: ZegoLiveRoomApi = {
        let user = ZegoHelper.user
        ZegoLiveRoomApi.setUserID(user.userId, userName: user.userName)
        
        guard let api = ZegoLiveRoomApi(appID: ZegoKeyCenter.appID, appSignature: ZegoKeyCenter.appKey) else {
            fatalError("ZegoLiveRoomApi init error")
        }
        
        api.setPublisherDelegate(self)
        
        return api
    }()
    
    let bridge: OCBridgeToCpp = OCBridgeToCpp()
    
    var isPreview: Bool = false {
        didSet {
            previewBtn.setTitle(isPreview ? "StopPreview":"StartPreview", for: .normal)
            previewBtn.isEnabled = true
        }
    }
    var isPublish: Bool = false {
        didSet {
            publishBtn.setTitle(isPublish ? "StopPublish":"StartPublish", for: .normal)
            publishBtn.isEnabled = true
        }
    }
    
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var publishBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loginRoom()
        
        //使用OC作为bridge来调用cpp部分
        bridgeToCppTest()
    }
    
    //MARK:Actions
    @objc func onPreview() {
        isPreview ? stopPreview():startPreview()
    }
    
    @objc func onPublish() {
        isPublish ? stopPublish():startPublish()
    }
    
    //MARK:Private
    func setupUI() {
        previewBtn.addTarget(self, action: #selector(onPreview), for: .touchUpInside)
        publishBtn.addTarget(self, action: #selector(onPublish), for: .touchUpInside)
    }
    
    func loginRoom() {
        //类型转换
        let role = Int32(ZEGO_ANCHOR.rawValue)
        api.loginRoom("ZegoSwiftDemo", roomName: "ZegoSwiftDemo", role: role) { [unowned self] (errorCode, streams) in
            self.previewBtn.isEnabled = true
            self.publishBtn.isEnabled = true
        }
    }
    
    func bridgeToCppTest() {
        bridge.api(api, enableAECWhenHeadsetDetected: true)
    }
    
    func startPreview() {
        api.setPreviewView(view)
        
        guard api.startPreview() else {
            print("startPreview failed")
            return
        }
        
        isPreview = true
    }
    
    func stopPreview() {
        api.stopPreview()
        api.setPreviewView(nil)
        isPreview = false
    }
    
    func startPublish() {
        let flag = Int32(ZEGO_SINGLE_ANCHOR.rawValue)
        api.startPublishing("ZegoSwiftDemo-\(ZegoHelper.user.userId!)", title: "ZegoSwiftDemo", flag: flag)
        self.publishBtn.isEnabled = false
    }
    
    func stopPublish() {
        api.stopPublishing()
        isPublish = false
    }
    
}

extension ZegoAnchorViewController : ZegoLivePublisherDelegate {
    func onPublishStateUpdate(_ stateCode: Int32, streamID: String!, streamInfo info: [AnyHashable : Any]!) {
        let success: Bool = stateCode == 0
        isPublish = success
    }
}
