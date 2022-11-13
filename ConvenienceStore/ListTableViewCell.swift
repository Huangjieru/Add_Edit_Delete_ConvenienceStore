//
//  ListTableViewCell.swift
//  ConvenienceStore
//
//  Created by jr on 2022/10/26.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var storeImageView: UIImageView!
    
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
