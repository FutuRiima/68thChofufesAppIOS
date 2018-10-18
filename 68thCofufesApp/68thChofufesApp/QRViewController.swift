//
//  QRViewController.swift
//  68thCofufesApp
//
//  Created by 麻生未来 on 2018/10/01.
//  Copyright © 2018年 68thChofufes. All rights reserved.
//

import UIKit
import ZXingObjC
import AVFoundation

var QRText: String = "Nothing"

var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得

class QRViewController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate{
    @IBOutlet weak var preview: UIView!
    
    
    var zxcapture: ZXCapture? = nil
    
    private let capture = ZXCapture()
    private var captured = false
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        capture.delegate = self
        capture.camera = capture.back()
        capture.layer.frame = preview.bounds
        view.layer.addSublayer(capture.layer)
        capture.start()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resorces that can be recreated.
    }
    @IBAction func CuptureCancel(_ sender: Any) {
        capture.layer.removeFromSuperlayer()
        dismiss(animated: true)
    }
    
}


extension QRViewController : ZXCaptureDelegate {
    
    func captureResult(_ capture: ZXCapture!, result: ZXResult!){
        guard !captured else {
            return
        }
        captured = true
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        capture.stop()
        
        if (result.barcodeFormat != kBarcodeFormatQRCode){
            return;
        }
        
        guard let urlString = result.text else {
            return
        }
        print("Result text: \(urlString)")
        QRText = urlString
        appDelegate.QRText = QRText //appDelegateにQRコードの中身を書き込み
        self.performSegue(withIdentifier: "toViewer", sender: nil)
    }
}

