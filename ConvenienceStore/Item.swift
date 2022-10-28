//
//  Item.swift
//  ConvenienceStore
//
//  Created by jr on 2022/10/26.
//

import Foundation
struct Item{
    
    let store:String
    let item:String
    
    let price:Int
    let discount:Bool
    let comment:String
}

enum Message:String{
    
    case store = "Pleace choose a store"
    case item = "Pleace choose a item"
    case price = "Pleace choose a price"
    case comment = "Pleace choose a comment"
}
