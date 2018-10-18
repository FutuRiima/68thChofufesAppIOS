//
//  ShopDetailViewController.swift
//  68thChofufesApp
//
//  Created by 麻生未来 on 2018/10/09.
//  Copyright © 2018年 68thChofufes. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var StoreImage: UIImageView!
    @IBOutlet weak var StoreName: UITextView!
    @IBOutlet weak var StoreOrga: UILabel!
    @IBOutlet weak var StoreAddres: UILabel!
    @IBOutlet weak var StoreIntro: UITextView!
    
    var storeListViewDatas = [StoreListViewData]()
    var StoreData: Any = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        StoreOrga.text = storeListViewData.StoreOrgaString
        StoreName.text = storeListViewData.StoreNameString
        //            Intro.text = storeListViewData.IntroString
        //            self.Intro.contentOffset = CGPoint(x: 0, y: -self.Intro.contentInset.top);
        
        if storeListViewData.StoreImage != nil{
            StoreImage.image = storeListViewData.StoreImage
        
        }else{
            StoreImage.image = UIImage(named: "noImage")
        
        }
*/
        // Do any additional setup after loading the view.
    }
    



}
