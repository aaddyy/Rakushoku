//
//  MyPageTVC3.swift
//  FoodHealth2
//
//  Created by 安高慎也 on 2016/08/08.
//  Copyright © 2016年 shinya.adaka. All rights reserved.
//

import UIKit

class MyPageTVC3: UITableViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var label1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        image1.tag = 1
        image2.tag = 2
        image3.tag = 3
        image4.tag = 4
        label1.tag = 5
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
