//
//  bookmarkTableViewCell.swift
//  TravelApp
//
//  Created by eda on 2.10.2022.
//

import UIKit

class bookmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backImageView.layer.cornerRadius = 6
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
