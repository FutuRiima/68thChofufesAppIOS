//
//  QRHomeViewController.swift
//  68thCofufesApp
//
//  Created by 麻生未来 on 2018/10/01.
//  Copyright © 2018年 68thChofufes. All rights reserved.
//

import UIKit

class QRHomeViewController: UIViewController {
    
    var QRCount: Int?
    var camera: Bool = true
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func CaptureButton(_ sender: Any) {
        camera = appDelegate.cameraCheck!
        if camera != true {
            let alert = UIAlertController(title: "Camera_Error", message: "使用できるカメラがありません！", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertButton)
            present(alert, animated: true, completion: nil)
            return
        }
        QRCount = appDelegate.QRCount!
        if QRCount != 0 {
            self.performSegue(withIdentifier: "toCapture", sender: nil)
        }
        else{
            let omakeAlert = UIAlertController(title: "おまけ券Error", message: "使用できるおまけ券がありません！", preferredStyle: .alert)
            let omakeAlertButton = UIAlertAction(title: "OK", style: .default, handler: {action in
                self.performSegue(withIdentifier: "toQuestion", sender: nil)
            })
            omakeAlert.addAction(omakeAlertButton)
            present(omakeAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func returnQRHome(segue: UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
