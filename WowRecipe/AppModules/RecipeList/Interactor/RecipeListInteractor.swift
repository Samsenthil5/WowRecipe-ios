//
//  RecipeListInteractor.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

class RecipeListInteractor: RecipeListInteractorProtocol {
    var presenter: RecipeListInteractorToPresenterProtocol?

    func fetchRecipeData() {
        presenter?.recipeDataSuccess(recipeList: SearchRecipeEntity.recipeResultLists)
    }
    func setRecipeDetail(recipeDetailUrl: String) {
        RecipeDetailsEntity.recipeDetailUrl = recipeDetailUrl
    }
    func loadRecipeImage(imageURL: URL, onCompletion: @escaping (_ response: UIImage?, _ success: Error?) -> Void) {
        ImageCacheUtility.getRecipeImageFromServer(url: imageURL.absoluteString, onCompletion: onCompletion)
    }
    func getRecipeName() -> String {
        return RecipeListEntity.recipeName ?? ""
    }
}
