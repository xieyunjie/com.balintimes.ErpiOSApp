//
//  CustomerCell.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/11.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CustomerCell: UITableViewCell {

    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblSignDate: UILabel!
    @IBOutlet weak var lblIndustry: UILabel!
    @IBOutlet weak var lblCustomerCategory: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellValue(value:String){
        self.lblCustomerName.text = "百事可乐百事可乐百事可乐";
        self.lblBrandName.text = "乐事薯片乐事薯片乐事薯片"
        
        self.lblSignDate.text = "2015-09-09";
        
    }

}
