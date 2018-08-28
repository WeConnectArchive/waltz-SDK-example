//
//  ViewController.swift
//  ThirdParty
//
//  Created by Guillaume Vachon on 2018-08-14.
//  Copyright © 2018 Waltz. All rights reserved.
//

import AVFoundation
import WaltzAccess

class ViewController: UIViewController, WltzTransactionMgrDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         the third party app is expected to request camera permissions on behalf of the SDK.
         Could be done in the SDK too. Following in the foot steps of on this one.
         */
        requestCameraPermission()
    }
    
    @IBAction func startTransaction(_ sender: UIButton) {
        /*
         The SDK needs a valid key to start the transaction.
         Please contact the Waltz team to have one.
         */
        WaltzTransactionMgr.sharedManager.beginTransaction(withLicenseKey: "PUT---YOUR---iOS---LICENSE---HERE")
        WaltzTransactionMgr.sharedManager.delegate = self
    }
    
    func didFinishWaltzTransactionWithErrorCode(_ errorCode: WltzTransactionResponseCodes) {
        print("The application quit with error code \(errorCode)")
    }
    
    func requestCameraPermission() {
        if AVCaptureDevice.responds(to: #selector(AVCaptureDevice.requestAccess(for:completionHandler:))) {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if granted {
                    
                } else {
                    
                }
            })
        } else {
            
        }
    }
}
