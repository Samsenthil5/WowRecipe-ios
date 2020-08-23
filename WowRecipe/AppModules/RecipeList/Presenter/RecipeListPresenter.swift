//
//  RecipeListPresenter.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

class RecipeListPresenter: RecipeListViewToPresenterProtocol {
    var view: RecipeListViewProtocol?
    var interactor: RecipeListInteractorProtocol?
    var router: RecipeListRouter?

    func fetchRecipeData() {
        interactor?.fetchRecipeData()
    }
    func setRecipeDetail(recipeDetailUrl: String) {
        interactor?.setRecipeDetail(recipeDetailUrl: recipeDetailUrl)
    }
    func loadRecipeImage(imageURL: URL, onCompletion: @escaping (_ response: UIImage?, _ success: Error?) -> Void) {
        interactor?.loadRecipeImage(imageURL: imageURL, onCompletion: onCompletion)
    }
    func pushToNextViewController(navigationController: UINavigationController) {
        router?.pushToNextViewController(navigationController: navigationController)
    }
    func getRecipeName() -> String {
        return interactor?.getRecipeName() ?? ""
    }
}

extension RecipeListPresenter: RecipeListInteractorToPresenterProtocol {
    func recipeDataSuccess(recipeList: [RecipeListModel]?) {
        Utils.loadViewOnMainQueue {
            self.view?.recipeDataSuccess(recipeList: recipeList)
        }
    }
}
