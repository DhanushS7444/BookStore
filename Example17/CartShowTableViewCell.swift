//
//  CartShowTableViewCell.swift
//  Example17
//
//  Created by Dhanush S on 04/06/19.
//  Copyright © 2019 Dhanush S. All rights reserved.
//

import UIKit

class CartShowTableViewCell: UITableViewCell {

    @IBOutlet weak var cartshowImage: UIImageView!
    @IBOutlet weak var cartshowName: UILabel!
    @IBOutlet weak var cartshowPrice: UILabel!
    @IBOutlet weak var cartshowCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
