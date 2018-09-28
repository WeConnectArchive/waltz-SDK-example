//
//  ViewController.swift
//  ThirdParty
//
//  Created by Guillaume Vachon on 2018-08-14.
//  Copyright © 2018 Waltz. All rights reserved.
//

import AVFoundation
import WaltzAccess

class ViewController: UIViewController, WltzSDKMgrDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         the third party app is expected to request camera permissions on behalf of the SDK.
         Could be done in the SDK too. Following in the foot steps of on this one.
         */
        requestCameraPermission()
        PermissionsChecker.sharedInstance.requestPermissionForNotifications()
        PermissionsChecker.sharedInstance.requestLocationPermission()
        
        WaltzSDKMgr.sharedManager.delegate = self
    }
    
    @IBAction func startTransaction(_ sender: UIButton) {
        /*
         The SDK needs a valid key to start the transaction.
         Please contact the Waltz team to have one.
         */
        WaltzSDKMgr.sharedManager.beginTransaction()
    }
    
    @IBAction func startGeofence(_ sender: UIButton) {
        UIApplication.shared.registerForRemoteNotifications()
        WaltzSDKMgr.sharedManager.startGeofenceService()
    }
    
    @IBAction func stopGeofence(_ sender: UIButton) {
        WaltzSDKMgr.sharedManager.stopGeofenceService()
    }
    
    func didFinishWaltzTransactionWithErrorCode(_ errorCode: SDKResponseCodes) {
        print("The application quit with error code \(errorCode)")
    }
    
    func didFinishWaltzGeofenceSetupWithErrorCode(_ errorCode: SDKResponseCodes) {
        print("The application quit with error code \(errorCode)")
    }
    
    func requestCameraPermission() {
        if AVCaptureDevice.responds(to: #selector(AVCaptureDevice.requestAccess(for:completionHandler:))) {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if granted {
                    PermissionsChecker.sharedInstance.cameraPermissionsHaveBeenGranted()
                } else {
                    
                }
            })
        } else {
            
        }
    }
}
