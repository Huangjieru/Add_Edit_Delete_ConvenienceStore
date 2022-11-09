//
//  TextField.swift
//  ConvenienceStore
//
//  Created by jr on 2022/11/9.
//

import Foundation
import UIKit

extension UITextField{
    func setKeyboardButton(){
        //設計滾輪
        //初始化pickerView上方的toolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = .systemMint
        //透明
        //        toolbar.isTranslucent = true
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//彈性的拉開與cancel之間的距離
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelButtonTap))
        //doneButton顏色
        doneButton.tintColor = .white
        //cancelButton顏色
        cancelButton.tintColor = .white
        //doneButton顯示在toolbar上
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        //inputAccessoryView 是輸入區塊上方的輔助區塊
        self.inputAccessoryView = toolbar

    }
  //按下按鈕後退選擇器
        @objc func doneButtonTap(){
            self.endEditing(true)
        }
        @objc func cancelButtonTap(){
            self.endEditing(true)
        }
}
