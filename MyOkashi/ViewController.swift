//
//  ViewController.swift
//  MyOkashi
//
//  Created by 漢那優太 on 2019/01/20.
//  Copyright © 2019 Yuta Kanna. All rights reserved.
//

import UIKit

class ViewController: UIViewController UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Search Barのdelegate通知先を設定
        searchText.delegate = self
        // 入力のヒントになる、プレースホルダを設定
        searchText.placeholder = "お菓子の名前を入力してください"
    }

    @IBOutlet weak var searchText: UISearchBar!
    
    
    @IBOutlet weak var tableView: UITableView!
}

