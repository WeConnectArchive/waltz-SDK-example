//
//  ViewController.swift
//  ThirdParty
//
//  Created by Guillaume Vachon on 2018-08-14.
//  Copyright © 2018 Waltz. All rights reserved.
//

import AVFoundation
import JWTDecode
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
    
    @IBAction func Login(_ sender: UIButton) {
        if let tabBarVC = parent as? UITabBarController {
            tabBarVC.selectedIndex = 1
        }
        
        WaltzSDKMgr.sharedManager.logIn()
    }
    
    @IBAction func startTransaction(_ sender: UIButton) {
        /*
         The SDK needs a valid key to start the transaction.
         Please contact the Waltz team to have one.
         */
        
        var viewController: NewCustomVC? = nil
        if let tabBarVC = parent as? UITabBarController {
            tabBarVC.selectedIndex = 2
            
            viewController = tabBarVC.viewControllers?[2] as? NewCustomVC
        }
        
        WaltzSDKMgr.sharedManager.beginTransaction(parentView: viewController?.customParentView, parentVC: viewController)
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
    
    func didFinishWaltzLogin(_ errorCode: SDKResponseCodes) {
        if let tabBarVC = parent as? UITabBarController {
            tabBarVC.selectedIndex = 0
        }
        
        print("The Login quit with error code \(errorCode)")
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
    
    func didUpdateWaltzFCMTokenWithErrorCode(_ errorCode: SDKResponseCodes) {
        print("The Update FCM token quit with error code \(errorCode)")
    }
    
    func didGetWaltzDDInfos(_ ddInfos: DDInfos) {
        print("We have received the DD infos elevator: \(ddInfos.elevator) floor: \(ddInfos.floor)")
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
        WaltzSDKMgr.sharedManager.getJWT()
    }
    
    func didGetWaltzJWTWithErrorCode(_ errorCode: SDKResponseCodes, jwt: JWT?) {
        print("The Get JWT quit with error code \(errorCode)")
        
        if errorCode == SUCCESS, let newJWT = jwt {
            responseTV.text = "Name: \(newJWT.body["firstName"]!) \(newJWT.body["lastName"]!)\nEmail: \(newJWT.body["userEmail"]!)\nID: \(newJWT.body["uid"]!)"
        }
    }
}
