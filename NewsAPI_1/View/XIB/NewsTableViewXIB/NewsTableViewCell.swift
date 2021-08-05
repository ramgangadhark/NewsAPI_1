//
//  NewsTableViewCell.swift
//  NewsAPI_1
//
//  Created by Ram on 06/07/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var NewsImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var swipeLeftLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func bottomBtnTap(_ sender: UIButton) {
    }
    
}
