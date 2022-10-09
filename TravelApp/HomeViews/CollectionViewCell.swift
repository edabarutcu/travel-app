//
//  CollectionViewCell.swift
//  TravelApp
//
//  Created by eda on 2.10.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var BACKvİEW: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        BACKvİEW.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
        // Initialization code
    }
}
