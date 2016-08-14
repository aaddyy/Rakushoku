//
//  RecipeTVC.swift
//  FoodHealth2
//
//  Created by 安高慎也 on 2016/07/30.
//  Copyright © 2016年 shinya.adaka. All rights reserved.
//

import UIKit

class RecipeTVC: UITableViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label1: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        image1.tag = 1
        label1.tag = 2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
