//
//  SugegestionsCollectionViewCell.swift
//  NewsAPI_1
//
//  Created by Ram on 07/07/21.
//

import UIKit

class SugegestionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var suggestionLbl: UILabel!
    @IBOutlet weak var suggestionImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        // Initialization code
    }

}
