//
//  CategoriesCollectionViewCell.swift
//  NewsAPI_1
//
//  Created by Ram on 07/07/21.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var categoryImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        // Initialization code
    }

}
