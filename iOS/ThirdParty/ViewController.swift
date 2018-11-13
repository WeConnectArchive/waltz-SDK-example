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

    @IBOutlet weak var licenseTF: UITextField!
    @IBOutlet weak var appUidTF: UITextField!
    @IBOutlet weak var responseTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        /*
         the third party app is expected to request camera permissions on behalf of the SDK.
         Could be done in the SDK too. Following in the foot steps of on this one.
         */
        requestCameraPermission()
        PermissionsChecker.sharedInstance.requestPermissionForNotifications()
        PermissionsChecker.sharedInstance.requestLocationPermission()
        
        navigationController?.navigationBar.addGestureRecognizer(tap)
        
        WaltzSDKMgr.sharedManager.delegate = self
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    
    @IBAction func getMyGuestsList(_ sender: UIButton) {
        responseTV.text = ""
        
        WaltzSDKMgr.sharedManager.getMyGuests()
    }
    
    @IBAction func getMyInvitationsList(_ sender: UIButton) {
        responseTV.text = ""
        
        WaltzSDKMgr.sharedManager.getMyInvitations()
    }
    
    @IBAction func sendInvitation(_ sender: UIButton) {
        responseTV.text = ""
        
        let firstName = "iOS SDK first name"
        let lastName = "iOS SDK last name"
        let email = "iossdk@example.com"
        let phoneNumber = "5145457878"
        
        let startDate = Date()
        let endDate = Date(timeIntervalSinceNow: 30*60)
        WaltzSDKMgr.sharedManager.sendInvitation(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, startDate: startDate, endDate: endDate)
    }
    
    func didFinishWaltzTransactionWithErrorCode(_ errorCode: SDKResponseCodes) {
        print("The Transaction quit with error code \(errorCode)")
    }
    
    func didFinishWaltzGeofenceSetupWithErrorCode(_ errorCode: SDKResponseCodes) {
        print("The Geofence quit with error code \(errorCode)")
    }
    
    func didGetWaltzMyGuestsWithErrorCode(_ errorCode: SDKResponseCodes, guests: [InvitationResponse]?) {
        print("The Get my Guests quit with error code \(errorCode)")

        if errorCode == SUCCESS {
            responseTV.text = try! guests!.toJSON().serializeString()
        }
    }
    
    func didGetWaltzMyInvitationsWithErrorCode(_ errorCode: SDKResponseCodes, invitations: [InvitationResponse]?) {
        print("The Get my Invitations quit with error code \(errorCode)")
        
        if errorCode == SUCCESS {
            responseTV.text = try! invitations!.toJSON().serializeString()
        }
    }
    
    func didSendWaltzInvitationWithErrorCode(_ errorCode: SDKResponseCodes) {
        print("The Send Invitation quit with error code \(errorCode)")
        
        if errorCode == SUCCESS {
            responseTV.text = "Success"
        }
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
    
    @IBAction func initSDK(_ sender: UIButton) {
         let _ = WaltzSDKMgr.sharedManager.initManager(licenseKey: licenseTF.text!, appUid: appUidTF.text!)
    }
    
    @IBAction func getUserInfo(_ sender: Any) {
        WaltzSDKMgr.sharedManager.getUserInfos()
    }
    
    func didGetWaltzUserInfoWithErrorCode(_ errorCode: SDKResponseCodes, userInfo: WaltzUserInfos?) {
        print("The Get UserInfo quit with error code \(errorCode)")
        
        if errorCode == SUCCESS, let newUserInfo = userInfo {
            responseTV.text = "Name: \(newUserInfo.name)\nEmail: \(newUserInfo.email)\nID: \(newUserInfo.id.uuidString)"
        }
    }
}
