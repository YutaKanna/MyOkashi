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
    
    // お菓子のリスト (タプル配列)
    var okashiList : [(name:String , maker:String , link:URL , image:URL)] = []
    
    // 検索ボタンをクリック(タップ) 時
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる
        view.endEditing(true)
        
        if let searchWord = searchBar.text {
            // デバッグエリアに出力
            print(searchWord)
            // 入力されたていたら、お菓子を検索
            searchOkashi(keyword: searchWord)
        }
    }
    // JSONのitem内のデータ構造
    struct ItemJson: Codable {
        // お菓子の名称
        let name: String?
        // メーカー
        let maker: String?
        // 掲載URL
        let url: URL?
        // 画像URL
        let image: URL?
    }
    
    // JSONのデータ構造
    struct ResultJson: Codable {
        //複数要素
        let item:[ItemJson]?
    }
    
    // searchOkashiメソッド
    // 第一引数 : keyword 検索したいワード
    func searchOkashi(keyword : String) {
        
        // お菓子の検索キーワードをURLエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: URLQueryAllowed) else {
            return
        }
        
        // リクエストURLの組み立て
        guard let req_url = URL(string: "http://www.sysbird.jp/toriko/api/?apiker=guest&format=json&keyword=\
            (keyword_encode)&max=10&order=r") else {
            return
        print(req_url)
        
        // リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        // データ転送を管理するためのセッションを生成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        // リクエストをタスクとして登録
        let task = session.dataTask(with: req, CompletionHandler: {
            (data , response , error) in
            // セッションを終了
            session.finishTasksAndInvalidate()
            // do try catch エラーハンドリング
            do {
                // JSONDecoderのインスタンスを取得
                let decoder = JSONDecoder()
                // 受け取ったJSONデータをパース(解析)して格納
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                print(json)
            } catch {
                // エラー処理
                print("エラーが出ました")
            }
        })
        // ダウンロード開始
        task.resume()
    }
}

