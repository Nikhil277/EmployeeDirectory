//
//  EmployeeTableViewCell.swift
//  EmployeeDirectory
//
//  Created by Nikhil B Kuriakose on 20/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCompanyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelName.text = ""
        labelCompanyName.text = ""
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.size.width/2
        imageViewProfile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
