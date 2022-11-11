//
//  EditTableViewController.swift
//  ConvenienceStore
//
//  Created by jr on 2022/10/26.
//

import UIKit
import Foundation

class EditTableViewController: UITableViewController, UITextFieldDelegate {

    var thing:Item?
    var isSelectedPhoto = false //是否選擇相簿
    
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
        
        //點選照片觸發選單功能（選擇相簿或拍照）
        photoImageView.isUserInteractionEnabled = true
        //價格輸入用數字鍵盤(todo return keyboard!)
        priceTextField.keyboardType = .numberPad
        priceTextField.setKeyboardButton()//在數字鍵盤上加上done, cancel的bar
        
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
    
    //MARK: - Action
    //Tap Gesture選照片或拍照
    @IBAction func selectPhoto(_ sender: UITapGestureRecognizer) {
 
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)//選單樣式
        let photoAction = UIAlertAction(title: "choose photo", style: .default) { action in
            self.selectphoto()
        }
        let cameraAction = UIAlertAction(title: "take picture", style: .default) { action in
            self.takePicture()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .default)
        
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
 
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
        
         //滾輪上done,cancel按鈕設計另外寫在TextField檔案裡的setKeyboardButton()
        
        //選擇店家滾輪
        pkvStore = UIPickerView()
        pkvStore.delegate = self
        pkvStore.dataSource = self
        pkvStore.tag = 1 //此處的tag編碼與store在storyboard的textField的tag編碼相同
        storeTextField.setKeyboardButton()
        //將輸入store欄位的鍵盤替換為滾輪 //inputView 是 text filed 輸入時從下方冒出的輸入區塊
        storeTextField.inputView = pkvStore
        
        //選擇評論滾輪
        pkvComment = UIPickerView()
        pkvComment.delegate = self
        pkvComment.dataSource = self
        pkvComment.tag = 2
        commentTextField.setKeyboardButton()
        commentTextField.inputView = pkvComment //鍵盤替換為滾輪
    }

    //return鍵盤
    //<方法一>從 UITextField 連結 IBAction，Event 選擇 Did End On Exit
    @IBAction func dismissItemKeyboard(_ sender: Any) {
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
        
        
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         //準備傳遞資料
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             var photoName:String?
             let store = storeTextField.text ?? ""
             let item = itemTextField.text ?? ""
             let date = datePicker.date
             let price = Int(priceTextField.text ?? "0") ?? 0
             let discount = discountSwitch.isOn
             let comment = commentTextField.text ?? ""
             //如果選擇照片
             if isSelectedPhoto{
                 if let item = thing{ //修改：改照片就用原本名字
                     photoName = item.photoName
                 }
                 if photoName == nil{ //新增：取新名字
                     photoName = UUID().uuidString
                 }
             }
        //圖片呼叫data
             //compressionQuality(0~1)來減少圖片容量
             let photoData = photoImageView.image?.jpegData(compressionQuality: 0.7)
             //圖片路徑：先讀出「資料夾」加上「圖片名稱」加上「副檔名」
             let photoURL = Item.documentsDirectory.appending(path: photoName!).appendingPathExtension("jpg")
             //將圖片存入路徑位置=>write是複寫，存入後之前的會被覆蓋掉
             //<方法一>try? photoData?.write(to: photoURL)
             //<方法二>
             do{
               let _ = try photoData?.write(to: photoURL)
             }catch{
                print("can't get photoURL")
             }
             
             
             thing = Item(photoName:photoName,store: store, item: item, date: date, price: price, discount: discount, comment: comment)
         }
  
    
}

//MARK: - UIImagePickerControllerDelegate
extension EditTableViewController:UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    //跳出相簿
    func selectphoto(){
        let imageContriller = UIImagePickerController()
        imageContriller.sourceType = .photoLibrary
        imageContriller.delegate = self
        present(imageContriller, animated: true)
    }
    //選擇照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isSelectedPhoto = true
        let picture = info [UIImagePickerController.InfoKey.originalImage] as! UIImage //Any型別轉型成UIImage,才可將照片加到Imageview上
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.image = picture
        //選完照片後退掉畫面
        dismiss(animated: true)
    }
    func takePicture(){
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.delegate = self
        present(controller, animated: true)
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

