//
//  NotificationTVC.swift
//  FoodHealth2
//
//  Created by 安高慎也 on 2016/08/06.
//  Copyright © 2016年 shinya.adaka. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        image1.tag = 1
        label1.tag = 2
        
        label1.textColor = UIColor.grayColor()
        label1.textAlignment = NSTextAlignment.Left
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
