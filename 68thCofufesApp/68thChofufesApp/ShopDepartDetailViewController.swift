//
//  ShopDepartDetailViewController.swift
//  68thChofufesApp
//
//  Created by 麻生未来 on 2018/10/09.
//  Copyright © 2018年 68thChofufes. All rights reserved.
//

import UIKit
import Firebase

var giveData: Any = []
var giveStoreImage: UIImage?


class ShopDepartDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var departTitleBar: UINavigationBar!
    @IBOutlet weak var table: UITableView!
    
    
    var departTitle: String?
    var departIndex: Int?
    var storeListViewDatas = [StoreListViewData]()
    var storeListViewDatasSaved = [StoreListViewData]()
    var ref: DatabaseReference!
    var refStoreDepart: DatabaseReference!
    var DataNumber: Int!
    let saveData: UserDefaults = UserDefaults.standard
    var storeImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        departTitleBar.topItem?.title = departTitle
        
        ref = Database.database().reference() //(withPath: "StoreNumber")
        refStoreDepart = Database.database().reference(withPath: "depart")
        
        table.dataSource = self
        table.delegate = self
        
        DataNumber = 0
        setInitdata()
        
        // Do any additional setup after loading the view.
    }
    
    func setInitdata() {
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        // Create a storage reference from our storage service
        let storageRef = storage.reference().child("StoreImage")

        ref.child("storeNumber").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for (_, child) in snapshot.children.enumerated(){
                let key: String = (child as AnyObject).key
                
                let storeOrga: String = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "storeOrga").value as! String
                let storeName: String = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "StoreName").value as! String
                let Intro: String = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "introduction").value as! String
                let departNumber: Int? = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "depart").value as? Int
                let StoreAddres: String? = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "StoreAddres").value as? String
                
                let Twitter : String?
                if snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "TwitterURL").exists() == true{
                    Twitter = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "TwitterURL").value as? String
                    print(Twitter!)
                }else{
                    Twitter = nil
                }
                
                let HP : String?
                if snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "HP").exists() == true{
                    HP = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "HP").value as? String
                    print(HP!)
                }else{
                    HP = nil
                }
                
                let Icon : String?
                if snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "StoreImage").exists() == true{
                    Icon = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "StoreImage").value as? String
                    print(Icon!)
                }else{
                    Icon = nil
                }
                
                var StoreImage : UIImage?
                var DefaultVer : Int? = self.saveData.object(forKey: "StoreImageVer" + storeName) as? Int
                if DefaultVer == nil{ DefaultVer = 0 }
                
                if snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "IconVer").exists() == true{
                    if DefaultVer! != snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "IconVer").value as! Int{
                        if Icon != nil{
                            let storeStorageRef = storageRef.child(Icon! + ".jpg")
                            storeStorageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                let number = Int(key)!
                                if error != nil {
                                    // Uh-oh, an error occurred!
                                    print("Error " + key)
                                    self.storeListViewDatas[number - 1].setStoreImage(StoreImage: nil)
                                    print(Icon! + ".jpg")
                                } else {
                                    // Data for "images/island.jpg" is returned
                                    print("Success " + number.description)
                                    StoreImage = UIImage(data: data!)
                                    let storeListViewData = self.storeListViewDatas[number - 1]
                                    storeListViewData.setStoreImage(StoreImage: StoreImage)
                                    self.saveData.set(StoreImage!.pngData(), forKey: "StoreImage" + storeName)
                                
                                }
                                self.saveData.set(snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "IconVer").value as! Int, forKey: "StoreImageVer" + storeName)
                                self.table.reloadData()
                            }
                        }
                    
                    }else{
                        print("Load " + key)
                    
                        if let Image = self.saveData.object(forKey: "StoreImage" + storeName){
                            StoreImage = UIImage(data: Image as! Data)
                        }else{
                            StoreImage = nil
                        }
                    }
                }
                self.DataNumber = Int(key)
                
                self.storeListViewDatas.append(StoreListViewData(StoreOrgaString: storeOrga, StoreNameString: storeName, IntroString: Intro, TwitterURL: Twitter, HPURL: HP, StoreImage: StoreImage,  departNumber: departNumber, StoreAddres: StoreAddres))
                self.storeListViewDatasSaved.append(StoreListViewData(StoreOrgaString: storeOrga, StoreNameString: storeName, IntroString: Intro, TwitterURL: Twitter, HPURL: HP, StoreImage: StoreImage, departNumber: departNumber, StoreAddres: StoreAddres))
                print("Added " + key)
                
            }
            self.table.reloadData()
        }
        )
        
        print("" + DataNumber.description)
        
 
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataNumber
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : StoreListViewCell = tableView.dequeueReusableCell(withIdentifier: "DepartDetailCell") as! StoreListViewCell
        cell.setCell(storeListViewData: storeListViewDatas[indexPath.row])
        cell.StoreOrga.textColor = UIColor.brown
        cell.StoreOrga.font = UIFont.systemFont(ofSize: 10)
        cell.StoreName.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? String.self)
        print("depart is \(String(describing: depart))")
        self.performSegue(withIdentifier: "toShopDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setInitdataReload() {
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        // Create a storage reference from our storage service
        let storageRef = storage.reference().child("StoreImage")
        
        ref.child("storeNumber").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for (_, child) in snapshot.children.enumerated(){
                let key: String = (child as AnyObject).key
                
                let storeOrga: String = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "storeOrga").value as! String
                let storeName: String = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "StoreName").value as! String
                let Intro: String = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "introduction").value as! String
                let departNumber: Int? = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "depart").value as? Int
                let StoreAddres: String = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "StoreAddres").value as! String
                
                let Twitter : String?
                if snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "TwitterURL").exists() == true{
                    Twitter = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "TwitterURL").value as? String
                    print(Twitter!)
                }else{
                    Twitter = nil
                }
                
                let HP : String?
                if snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "HP").exists() == true{
                    HP = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "HP").value as? String
                    print(HP!)
                }else{
                    HP = nil
                }
                
                let Icon : String?
                if snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "StoreImage").exists() == true{
                    Icon = snapshot.childSnapshot(forPath: key).childSnapshot(forPath: "StoreImage").value as? String
                    print(Icon!)
                }else{
                    Icon = nil
                }
                
                var StoreImage : UIImage?
                var DefaultVer : Int? = self.saveData.object(forKey: "StoreImageVer" + storeName) as? Int
                if DefaultVer == nil{ DefaultVer = 0 }
                
                if Icon != nil{
                    let storeStorageRef = storageRef.child(Icon! + ".jpg")
                    storeStorageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        let number = Int(key)!
                        if error != nil {
                            // Uh-oh, an error occurred!
                            print("Error " + key)
                            self.storeListViewDatas[number - 1].setStoreImage(StoreImage: nil)
                            
                        } else {
                            // Data for "images/island.jpg" is returned
                            print("Success " + number.description)
                            StoreImage = UIImage(data: data!)
                            let storeListViewData = self.storeListViewDatas[number - 1]
                            storeListViewData.setStoreImage(StoreImage: StoreImage)
                            self.saveData.set(StoreImage!.pngData(), forKey: "StoreImage" + storeName)
                                    
                        }
                        self.table.reloadData()
                    }
                }
                        
                
                self.DataNumber = Int(key)
                
                self.storeListViewDatas.append(StoreListViewData(StoreOrgaString: storeOrga, StoreNameString: storeName, IntroString: Intro, TwitterURL: Twitter, HPURL: HP, StoreImage: StoreImage,  departNumber: departNumber, StoreAddres: StoreAddres))
                self.storeListViewDatasSaved.append(StoreListViewData(StoreOrgaString: storeOrga, StoreNameString: storeName, IntroString: Intro, TwitterURL: Twitter, HPURL: HP, StoreImage: StoreImage, departNumber: departNumber, StoreAddres: StoreAddres))
                print("Added " + key)
                
            }
            self.table.reloadData()
        }
        )
        
        print("" + DataNumber.description)
        
        
    }

    @IBAction func RefreshButton(_ sender: Any) {
        setInitdataReload()
    }

}

class StoreListViewData: NSObject {
    var StoreOrgaString: String
    var StoreNameString: String
    var IntroString: String
    var TwitterURL: String?
    var HPURL: String?
    var StoreImage: UIImage?
    var departNumber: Int?
    var StoreAddres: String?
    
    init(StoreOrgaString: String, StoreNameString: String, IntroString: String, TwitterURL: String?, HPURL: String?, StoreImage: UIImage?, departNumber: Int?, StoreAddres: String?) {
        self.StoreOrgaString = StoreOrgaString
        self.StoreNameString = StoreNameString
        self.IntroString = IntroString
        self.TwitterURL = TwitterURL
        self.HPURL = HPURL
        self.StoreImage = StoreImage
        self.departNumber = departNumber
        self.StoreAddres = StoreAddres
    }
    
    func setStoreImage(StoreImage : UIImage?) {
        self.StoreImage = StoreImage
    }
}



class StoreListViewCell: UITableViewCell {
    @IBOutlet weak var StoreImage: UIImageView!
    @IBOutlet weak var StoreName: UITextView!
    @IBOutlet weak var StoreOrga: UILabel!
//        @IBOutlet weak var Intro: UITextView!
//        @IBOutlet weak var Twitter: UIImageView!
//        @IBOutlet weak var HP: UIImageView!
    
        func setCell(storeListViewData: StoreListViewData) {
            StoreOrga.text = storeListViewData.StoreOrgaString
            StoreName.text = storeListViewData.StoreNameString
//            Intro.text = storeListViewData.IntroString
//            self.Intro.contentOffset = CGPoint(x: 0, y: -self.Intro.contentInset.top);
            
            if storeListViewData.StoreImage != nil{
                StoreImage.image = storeListViewData.StoreImage
                
            }else{
                StoreImage.image = UIImage(named: "noImage")
                
            }
            //Intro.setContentOffset(CGPoint.zero, animated: false)
        }
}
