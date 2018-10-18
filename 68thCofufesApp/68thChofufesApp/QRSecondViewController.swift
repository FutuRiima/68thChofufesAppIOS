//
//  QRSecondViewController.swift
//  68thCofufesApp
//
//  Created by 麻生未来 on 2018/10/01.
//  Copyright © 2018年 68thChofufes. All rights reserved.
//

import UIKit
import AVFoundation

class QRSecondViewController: UIViewController {
    @IBOutlet weak var QRTextView: UITextView!
    
    var QRText: String?
    var QRCount: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        guard appDelegate.QRCount != nil else {
            return
        }
        QRCount = appDelegate.QRCount!
        QRText = appDelegate.QRText //AppDelegateからQRコードの中身を取得
        
        if QRText == "68thChofufesOmakeTicket" {
            AudioServicesPlaySystemSound(1000)
            
            
            if QRCount > 0 {                //おまけ券の使用処理
                QRCount = QRCount - 1
                appDelegate.QRCount = QRCount
            }
            
            switch QRCount {
            case 2:
                print("2 remain ticket.")
                QRTextView.text = "残り2回です。\n\(String(describing: QRText))"
            case 1:
                print("1 remain ticket.")
                QRTextView.text = "残り1回です。\n\(String(describing: QRText))"
            case 0:
                print("no remain ticket.")
                QRTextView.text = "残り0回です。\n\(String(describing: QRText))"
            default:
                print("out of service")
            }
        }
        else {
            QRTextView.text = "This QRcode can not use.\n\(String(describing: QRText))"
        }
        
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
