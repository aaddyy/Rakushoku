//
//  RestaurantTVC.swift
//  FoodHealth2
//
//  Created by 安高慎也 on 2016/08/03.
//  Copyright © 2016年 shinya.adaka. All rights reserved.
//

import UIKit

class RestaurantTVC: UITableViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        image1.tag = 1
        label1.tag = 2
        label2.tag = 3
        label3.tag = 4
        
        label1.textColor = UIColor.grayColor()
        label1.textAlignment = NSTextAlignment.Center
        label1.backgroundColor = imageColor1
        label1.layer.cornerRadius = 16
        label2.textColor = UIColor.grayColor()
        label3.textColor = UIColor.grayColor()
        label3.textAlignment = NSTextAlignment.Center
        label3.backgroundColor = UIColor.whiteColor()
        label3.layer.cornerRadius = 4
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
