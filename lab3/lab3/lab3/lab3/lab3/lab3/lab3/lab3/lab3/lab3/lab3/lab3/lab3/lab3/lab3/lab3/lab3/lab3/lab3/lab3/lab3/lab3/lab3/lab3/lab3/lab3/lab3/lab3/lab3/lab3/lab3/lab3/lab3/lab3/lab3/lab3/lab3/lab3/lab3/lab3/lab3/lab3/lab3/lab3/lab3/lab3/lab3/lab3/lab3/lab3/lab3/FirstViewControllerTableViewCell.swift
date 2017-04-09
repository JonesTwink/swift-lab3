//
//  FirstViewControllerTableViewCell.swift
//  lab3
//
//  Created by Admin on 03.04.17.
//  Copyright © 2017 arthur. All rights reserved.
//

import UIKit

class FirstViewControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var weatherTemp: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
