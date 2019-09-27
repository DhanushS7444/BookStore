//
//  FirstTableViewCell.swift
//  Example17
//
//  Created by Dhanush S on 04/06/19.
//  Copyright © 2019 Dhanush S. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookPriceLabel : UILabel!
    @IBOutlet weak var bookCountLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
