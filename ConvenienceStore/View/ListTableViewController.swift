//
//  ListTableViewController.swift
//  ConvenienceStore
//
//  Created by jr on 2022/10/26.
//

import UIKit

class ListTableViewController: UITableViewController {
    //儲存資料
    var items = [Item](){ //property observer應用儲存資料
        didSet{ //array 有變動時存檔
            Item.saveItems(items)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        //App目前路徑-><方法一>Plist檔案/<方法二>documentDirectory
        print(NSHomeDirectory())
        
        //讀檔得到之前儲存的資料
        if let things = Item.loadItems(){
            self.items = things
        }
    }
    
    
    @IBAction func goToEdit(_ sender: UIBarButtonItem) {
        
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "EditTableViewController") else {return}
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func configure(cell:ListTableViewCell, forItemAt indexPath: IndexPath){
//        印出來會有時間，修改格式，只顯示年月日
                let outputDataFormatter = DateFormatter()
                outputDataFormatter.dateFormat = "yyyy, MM, dd"
                // Configure the cell...
                let thing = items[indexPath.row]

                cell.itemLabel.text = thing.item
                cell.dateLabel.text = outputDataFormatter.string(from: thing.date)
                cell.priceLabel.text = "$ " + String(thing.price)
                cell.commentLabel.text = thing.comment
                cell.storeImageView.image = UIImage(named: thing.store)
        
        
        let documentDirectory  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageURL = documentDirectory.appendingPathComponent("\(thing.photoName ?? "").jpg")
            cell.photoImageView?.image = UIImage(contentsOfFile: imageURL.path)
//        print("圖片有傳到此頁：\(String(describing: thing.photoName!))")
//        print(imageURL)
        
                tableView.rowHeight = 180
                cell.itemLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
                cell.priceLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
                cell.commentLabel.font = UIFont.systemFont(ofSize: 25)
                cell.storeImageView.contentMode = .scaleAspectFit
                cell.storeImageView.layer.cornerRadius = 12
        
                cell.photoImageView.contentMode = .scaleAspectFill
                cell.photoImageView.layer.cornerRadius = 8
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ListTableViewCell.self)", for: indexPath) as! ListTableViewCell
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    
    //刪除。屬於UITableViewDataSource protocol 的 function
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //先從記憶體刪除，在刪除陣列裡資料
        try? FileManager.default.removeItem(at: items[indexPath.row].photoURL)
        //左滑 cell 將出現 delete 的 button
        items.remove(at: indexPath.row)
        Item.saveItems(items)
        //畫面更新，刪除cell上的資料
//        tableView.reloadData() //要點選delete按鈕才能刪除，滑得無法刪除
        //delete 的動畫。tableView.reloadData()二選一寫
        tableView.deleteRows(at: [indexPath], with: .middle) //->滑掉或按刪除按鈕都可刪除
        //<補充>東⻄從 array 移除後,才呼叫deleteRowsAtIndexPaths: withRowAnimation:，否則會閃退。因為 numberOfRows(inSection:) 回傳的 cell 數量要與東⻄刪除後的數量相同
        print(indexPath, items)
    }
    
    //退掉編輯頁面回到前一頁（此頁）
    @IBAction func unwindToListTableViewControllerWithSegue(_ unwindSegue: UIStoryboardSegue) {
        //修改
        if let sourceViewController = unwindSegue.source as? EditTableViewController, let thing = sourceViewController.thing
        {
            //當 indexPathForSelectedRow 有值時表示修改,否則為新增
            if let indexPath = tableView.indexPathForSelectedRow{
                //從編輯頁傳回此頁
                items[indexPath.row] = thing
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }else{
                //新增
                items.insert(thing,at: 0) //加入陣列
                
                let NewIndexPath = IndexPath(row: 0, section: 0)
                //列表頁新增加入的動畫
                tableView.insertRows(at: [NewIndexPath], with: .fade)
                tableView.reloadData()
            }
    }
        
        //<補充>新增時 indexPathForSelectedRow 是 nil,點選 cell 修改時 indexPathForSelectedRow 才會有值
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //修改資料傳到下一頁
        if let controller = segue.destination as? EditTableViewController, let row = tableView.indexPathForSelectedRow?.row{
            controller.thing = items[row]
        }
    }
}
