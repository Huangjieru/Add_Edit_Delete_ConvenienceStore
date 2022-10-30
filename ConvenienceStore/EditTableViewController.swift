//
//  EditTableViewController.swift
//  ConvenienceStore
//
//  Created by jr on 2022/10/26.
//

import UIKit

class EditTableViewController: UITableViewController {

    var thing:Item?
    
    var pkvStore:UIPickerView!
    var pkvComment:UIPickerView!
    
    let storeArray = ["","7-11","Family","Hi-Life","OK"]
    let commentArray = ["","🤩","😐","😥","🤔"]
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var storeTextField: UITextField!
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var discountSwitch: UISwitch!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        //顯示要修改的資料
        editorUpdateUI()
        //顯示日期選擇
        createDatePicker()
        //顯示滾輪
        createPickerView()
        
    }
    func updateUI(){
        
        tableView.separatorStyle = .none
        photoImageView.image = UIImage(systemName: "photo.fill")
        storeTextField.placeholder = "Pleace type the store."
        itemTextField.placeholder = "Pleace type the item."
        priceTextField.placeholder = "How much it is?"
        commentTextField.placeholder = "Comment here!2 "
        
        let font = UIFont.systemFont(ofSize: 18, weight: .regular)
        storeTextField.font = font
        itemTextField.font = font
        priceTextField.font = font
        commentTextField.font = font
    }
    //修改資料傳到編輯頁，顯示之前的記錄
    func editorUpdateUI(){
        if thing != nil{
            storeTextField.text = thing?.store
            itemTextField.text = thing?.item
            datePicker.date = thing!.date
            priceTextField.text = thing?.price.description
            commentTextField.text = thing?.comment
            
        }
    }
    //建立日期選擇器
    func createDatePicker(){
        print("date")
        //選擇日期時的呈現樣式
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        
        datePicker.locale = .autoupdatingCurrent
        //預設為今天
        datePicker.date = .now
        
    }
    //建立的滾輪
    func createPickerView(){
        pkvStore = UIPickerView()
        pkvStore.delegate = self
        pkvStore.dataSource = self
        
        pkvStore.tag = 1 //此處的tag編碼與store在storyboard的textField的tag編碼相同
        //將輸入store欄位的鍵盤替換為滾輪
//        storeTextField.inputView = pkvStore
        //設計滾輪
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = .systemMint
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
        //doneButton顏色
        doneButton.tintColor = .white
        //doneButton顯示在toolbar上
        toolbar.setItems([doneButton], animated: true)
        //inputAccessoryView 是輸入區塊上方的輔助區塊
        storeTextField.inputAccessoryView = toolbar
        //將輸入store欄位的鍵盤替換為滾輪 //inputView 是 text filed 輸入時從下方冒出的輸入區塊
        storeTextField.inputView = pkvStore
        
        pkvComment = UIPickerView()
        pkvComment.delegate = self
        pkvComment.dataSource = self
        pkvComment.tag = 2
        commentTextField.inputAccessoryView = toolbar
        commentTextField.inputView = pkvComment
        
    }
    @objc func doneButtonTap(){
        self.view.endEditing(true)
    }
    
    // MARK: - Table view data source

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if storeTextField.text?.isEmpty == false, itemTextField.text?.isEmpty == false, priceTextField.text?.isEmpty == false, commentTextField.text?.isEmpty == false{
            return true
        }else if storeTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "\(Message.store.rawValue)", message: "Where you bought the item?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }else if itemTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "\(Message.item.rawValue)", message: "What did you buy?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }else if priceTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "\(Message.price.rawValue)", message: "How much it is?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }else if commentTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "\(Message.comment.rawValue)", message: "How about it?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        
        }
        return false
    }
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             
             let store = storeTextField.text ?? ""
             let item = itemTextField.text ?? ""
             let date = datePicker.date
             let price = Int(priceTextField.text ?? "0") ?? 0
             let discount = discountSwitch.isOn
             let comment = commentTextField.text ?? ""
             
             thing = Item(store: store, item: item, date: date, price: price, discount: discount, comment: comment)
         }
         
    
}

//MARK: - UIPickerViewDataSource
extension EditTableViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    //有幾個滾輪
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //一個滾輪裡有幾行(row)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 1:
            return storeArray.count
        case 2:
            return commentArray.count
        default:
            return 0 //隨便給值 因為不會飽到default段
        }
        
    }
    //滾輪裡顯示陣列資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 1:
            return storeArray[row]
        case 2:
            return commentArray[row]
        default:
            return "Nothing"
        }
        
    }
    //滾輪滾動到特定位置時TextField顯示該文字
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 1:
            storeTextField.text = storeArray[row]
        case 2:
            commentTextField.text = commentArray[row]
        default:
            break
        }
        
    }
    
}
