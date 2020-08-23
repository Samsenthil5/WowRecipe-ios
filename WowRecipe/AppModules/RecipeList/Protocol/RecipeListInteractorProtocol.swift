//
//  RecipeListInteractorProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeListInteractorProtocol: class {
    var presenter: RecipeListInteractorToPresenterProtocol? {get set}
    func fetchRecipeData()
    func setRecipeDetail(recipeDetailUrl: String)
    func loadRecipeImage(imageURL: URL, onCompletion: @escaping (_ response: UIImage?, _ success: Error?) -> Void)
    func getRecipeName() -> String
}
