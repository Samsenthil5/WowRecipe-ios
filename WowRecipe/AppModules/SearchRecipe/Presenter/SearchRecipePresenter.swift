//
//  SearchRecipePresenter.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

class SearchRecipePresenter: SearchRecipeViewToPresenterProtocol {
    var view: SearchRecipeViewProtocol?
    var interactor: SearchRecipeInteractorProtocol?
    var router: SearchRecipeRouter?

    func fetchRecipeData(searchRecipeTxt: String) {
        interactor?.fetchRecipeData(searchRecipeTxt: searchRecipeTxt)
    }
    func pushToNextViewController(navigationController: UINavigationController) {
        router?.pushToNextViewController(navigationController: navigationController)
    }
}
extension SearchRecipePresenter: SearchRecipeInteractorToPresenterProtocol {
    func fetchRecipeDataSuccess(recipeLists: [RecipeListModel]?) {
        Utils.loadViewOnMainQueue {
            self.view?.fetchRecipeDataSuccess(recipeLists: recipeLists)
        }
    }
    func fetchRecipeDataFailure(errorMessage: String) {
        Utils.loadViewOnMainQueue {
            self.view?.fetchRecipeDataFailure(errorMessage: errorMessage)
        }
    }
}
