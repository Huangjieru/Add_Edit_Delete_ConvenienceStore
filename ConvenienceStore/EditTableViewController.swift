//
//  EditTableViewController.swift
//  ConvenienceStore
//
//  Created by jr on 2022/10/26.
//

import UIKit

class EditTableViewController: UITableViewController {

    var thing:Item?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var storeTextField: UITextField!
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var discountSwitch: UISwitch!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if storeTextField.text?.isEmpty == false, itemTextField.text?.isEmpty == false, priceTextField.text?.isEmpty == false, commentTextField.text?.isEmpty == false{
            return true
        }else if storeTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "\(Message.store)", message: "Where you bought the item?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }else if itemTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "\(Message.item)", message: "What did you buy?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }else if priceTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "\(Message.price)", message: "How much it is?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }else if commentTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "\(Message.comment)", message: "How about it?", preferredStyle: .alert)
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
             var item = itemTextField.text ?? ""
             
             let price = Int(priceTextField.text!) ?? 0
             let discount = discountSwitch.isOn
             let comment = commentTextField.text ?? ""
             
             thing = Item(store: store, item: item, price: price, discount: discount, comment: comment)
         }
         
    
}
