//
//  CustomTableViewCell.swift
//  SwiftWebService
//
//  Created by Samit Koyom on 15/1/59.
//  Copyright © พ.ศ. 2559 Samit Koyom. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var mPersonImage: UIImageView!
    @IBOutlet weak var mFullname: UILabel!
    @IBOutlet weak var mEmail: UILabel!
    @IBOutlet weak var mTel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
