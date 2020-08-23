//
//  RecipeListPresenterProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeListViewToPresenterProtocol: class {
    var view: RecipeListViewProtocol? {get set}
    var interactor: RecipeListInteractorProtocol? {get set}
    var router: RecipeListRouter? {get set}
    func fetchRecipeData()
    func setRecipeDetail(recipeDetailUrl: String)
    func loadRecipeImage(imageURL: URL, onCompletion: @escaping (_ response: UIImage?, _ success: Error?) -> Void)
    func getRecipeName() -> String
    func pushToNextViewController(navigationController: UINavigationController)
}
protocol RecipeListInteractorToPresenterProtocol: class {
    func recipeDataSuccess(recipeList: [RecipeListModel]?)

}
