//
//  FirstViewController.swift
//  68thCofufesApp
//
//  Created by 麻生未来 on 2018/10/01.
//  Copyright © 2018年 68thChofufes. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    @IBAction func returnHome(segue: UIStoryboardSegue){
    }

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // check if camera device is availabel
        guard AVCaptureDevice.default(for: AVMediaType.video) != nil else {
            print("error_no_camera")
            appDelegate.cameraCheck = false
            return
        }
        
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        switch (status) {
        case .authorized: //ok
            appDelegate.cameraCheck = true
            break
        case .denied: //ng
            appDelegate.cameraCheck = true
            print("error_camera_denied")
        case .restricted: //?
            break
        case .notDetermined:
            appDelegate.cameraCheck = true
            //first time
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> () in
                if !granted{
                    print("error_camera_denied")
                    return
                }})
        }
    }


}

