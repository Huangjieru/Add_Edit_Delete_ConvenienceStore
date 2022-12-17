//
//  Item.swift
//  ConvenienceStore
//
//  Created by jr on 2022/10/26.
//

import Foundation

struct Item:Codable{ //要 Codable or Encodable 才能轉成 Data
    let photoName:String?
    let store:String
    let item:String
    let date:Date
    let price:Int
    let discount:Bool
    let comment:String
    
    var photoURL:URL {
        Item.documentsDirectory.appendingPathComponent(photoName ?? "")
    }
    /*
     //<方法一>UserDefaults
     //UserDefaults使用者預設資料庫，透過key-value儲存資料到App內。
     //利用 decoder 將 Data 轉成自訂型別的資料
     static func loadItems() -> [Item]?{
     //透過該類別變數取得預設的UserDefaults實體
     let userDefaults = UserDefaults.standard
     //藉由對應的key取得之前儲存的資料
     guard let data = userDefaults.data(forKey: "items") else { return nil}
     let decoder = JSONDecoder()
     return try? decoder.decode([Item].self, from: data)
     }
     
     //存檔：利用 encoder 將資料轉成 Data 寫檔
     static func saveItems(_ items: [Item]){
     let encoder = JSONEncoder()
     guard let data = try? encoder.encode(items) else { return }
     let userDefaults = UserDefaults.standard
     //將值放到參數內，設置對應key
     userDefaults.set(data, forKey: "items")
     }*/
    
    //<方法二>
    //取得資料夾的位置。App一產生就會有documents資料夾
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func loadItems() -> [Self]?{ //有可能讀到東西也可能沒讀到
        let decoder = JSONDecoder()
        let url = documentsDirectory.appendingPathExtension("items")
        guard let data = try? Data(contentsOf: url) else {return nil}
        return try? decoder.decode([Self].self, from: data)
        
    }
    
    static func saveItems(_ items:[Self]){ //Self (大寫的 S) 代表型別 Item
        let encoder = JSONEncoder()
        let data = try? encoder.encode(items)
        let url = documentsDirectory.appendingPathExtension("items")
        try? data?.write(to: url)
    }
}

enum Message:String{
    
    case store = "Pleace choose a store"
    case item = "Pleace choose a item"
    case price = "Pleace choose a price"
    case comment = "Pleace choose a comment"

}


