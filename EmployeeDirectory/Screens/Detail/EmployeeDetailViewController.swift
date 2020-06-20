//
//  EmployeeDetailViewController.swift
//  EmployeeDirectory
//
//  Created by Nikhil B Kuriakose on 20/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

    var employeeDetails: Employee?
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelEmilAddress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = employeeDetails?.name
        imageViewProfile.sd_setImage(with: URL(string: employeeDetails?.imageUrl ?? ""), placeholderImage: nil, options: .refreshCached, context: nil)
        labelEmilAddress.text = employeeDetails?.emailAddress
    }
    

}
