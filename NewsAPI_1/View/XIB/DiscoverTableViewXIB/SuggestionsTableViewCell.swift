//
//  SuggestionsTableViewCell.swift
//  NewsAPI_1
//
//  Created by Ram on 06/07/33.
//

import UIKit

class SuggestionsTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var suggestionCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        suggestionCollectionView.register(UINib(nibName: "SugegestionsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SugegestionsCollectionViewCell")
        suggestionCollectionView.delegate = self
        suggestionCollectionView.dataSource = self
        suggestionCollectionView.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        // Initialization code
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = suggestionCollectionView.dequeueReusableCell(withReuseIdentifier: "SugegestionsCollectionViewCell", for: indexPath) as! SugegestionsCollectionViewCell
        cell.suggestionImgView.image = UIImage(named: "category0\(indexPath.row)")
        cell.suggestionLbl.text = Constants.categoryArray1[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let CVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        CVC.modalPresentationStyle = .fullScreen
        let navigationController = self.window?.rootViewController as! UINavigationController
        
        navigationController.pushViewController(CVC, animated: true, completion: {
            //CVC.newsUrl = "\(self.urlArray[self.index])"
            CVC.index = indexPath.row
        })
    }
}
