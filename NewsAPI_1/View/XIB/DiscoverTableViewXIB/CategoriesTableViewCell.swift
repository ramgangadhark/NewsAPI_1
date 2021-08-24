//
//  CategoriesTableViewCell.swift
//  NewsAPI_1
//
//  Created by Ram on 06/07/33.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageLbl: UIImageView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var categoryArr:[String] = ["MY FEED","ALL NEWS","TOP STORIES","TRENDING","BOOKMARKS","UNREAD"]
    override func awakeFromNib() {
        super.awakeFromNib()
        categoriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        
        
        //collectionView.register(UINib(nibName: "CollectionViewCell3", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell3")
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        // Initialization code
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.categoryImgView.image = UIImage(named: "Img0\(indexPath.row)")
        //print(indexPath.row)
        cell.categoryLbl.text = "\(categoryArr[indexPath.row])"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 150)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
