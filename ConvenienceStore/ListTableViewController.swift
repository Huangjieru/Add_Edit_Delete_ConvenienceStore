//
//  ListTableViewController.swift
//  ConvenienceStore
//
//  Created by jr on 2022/10/26.
//

import UIKit

class ListTableViewController: UITableViewController {
    //儲存資料
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

        // Configure the cell...
        let thing = items[indexPath.row]
        cell.itemLabel.text = thing.item
//        cell.dateLabel.text = thing.date.description
        cell.priceLabel.text = "$ " + String(thing.price)
        cell.commentLabel.text = thing.comment
        
        tableView.rowHeight = 150
        cell.itemLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        cell.priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return cell
    }
    //刪除。屬於UITableViewDataSource protocol 的 function
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //左滑 cell 將出現 delete 的 button
        items.remove(at: indexPath.row)
        //畫面更新，刪除cell上的資料
//        tableView.reloadData() //要點選delete按鈕才能刪除，滑得無法刪除
        //delete 的動畫。tableView.reloadData()二選一寫
        tableView.deleteRows(at: [indexPath], with: .middle) //->滑掉或按刪除按鈕都可刪除
        //<補充>東⻄從 array 移除後,才呼叫deleteRowsAtIndexPaths: withRowAnimation:，否則會閃退。因為 numberOfRows(inSection:) 回傳的 cell 數量要與東⻄刪除後的數量相同
    }
    
    //Step1.退掉編輯頁面回到前一頁（此頁）
    @IBAction func unwindToListTableViewControllerWithSegue(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? EditTableViewController,let item = sourceViewController.thing{
            items.insert(item,at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            //列表頁新增動畫
            tableView.insertRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        // Use data from the view controller which initiated the unwind segue
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
