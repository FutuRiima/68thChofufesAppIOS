//
//  ShopDepartViewController.swift
//  68thChofufesApp
//
//  Created by 麻生未来 on 2018/10/09.
//  Copyright © 2018年 68thChofufes. All rights reserved.
//

import UIKit

var depart: String?
var departIndex: Int?

class ShopDepartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBAction func returnShopHome(segue: UIStoryboardSegue){
    }
    //部門の配列
    var depart_array:[String] = ["模擬店","教室展示","本部企画","外部注文企画","ステージ","その他"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depart_array.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //部門セルの作成
        let departCell = UITableViewCell(style: .default, reuseIdentifier: "departCell")
        
        //配列から部門名を取得
        let departName = depart_array[indexPath.row]
        
        //セル内容の設定
        departCell.textLabel?.text = departName
        departCell.accessoryType = .disclosureIndicator
        departCell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        
        return departCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextvc = segue.destination as! ShopDepartDetailViewController
        nextvc.departTitle = depart
        nextvc.departIndex = departIndex
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? String.self)
//        print("depart is \(String(describing: depart))")
        depart = tableView.cellForRow(at: indexPath)!.textLabel!.text
        departIndex = depart_array.index(of: tableView.cellForRow(at: indexPath)!.textLabel!.text!)! + 1
//        print("Index is \(String(describing: departIndex))")
        self.performSegue(withIdentifier: "toDepartDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
