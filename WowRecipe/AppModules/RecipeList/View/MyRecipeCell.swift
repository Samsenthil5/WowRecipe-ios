//
//  MyRecipeCell.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/22/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import UIKit

protocol MyRecipeCellDelegate: class {
    // Shop Recipe Callback
    func shopRecipeAction(cell: MyRecipeCell, indexPath: IndexPath)
}
class MyRecipeCell: UICollectionViewCell {
    @IBOutlet weak var recipeThumbnailImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var receipIngredientsLabel: UILabel!
    @IBOutlet weak var shopRecipeButton: UIButton!
    weak var delegate: MyRecipeCellDelegate?
    var indexPath: IndexPath!

    // MARK: - Configure Recipe Cell
    func configureRecipes(recipeList: [RecipeListModel]?,
                          indexPath: IndexPath,
                          presenter: RecipeListViewToPresenterProtocol?) {
        self.indexPath = indexPath
        guard let list = recipeList else {
            return
        }
        recipeTitleLabel.text = list[indexPath.row].title ?? ""
        receipIngredientsLabel.text = list[indexPath.row].ingredients ?? ""
        // placeholder image
        recipeThumbnailImageView.image = #imageLiteral(resourceName: "placeholderImage")
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5
        if let thumbnailUrl = URL(string: list[indexPath.row].thumbnail ?? "") {
            dLog(thumbnailUrl)
            DispatchQueue.global(qos: .background).async {
                presenter?.loadRecipeImage(imageURL: thumbnailUrl, onCompletion: { (image, _) in
                    Utils.loadViewOnMainQueue {
                        self.recipeThumbnailImageView.image = image
                    }
                })
            }
        }
    }
    @IBAction func onClickShopRecipe(_ sender: Any) {
        delegate?.shopRecipeAction(cell: self, indexPath: indexPath)
    }
}
