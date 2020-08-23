//
//  RecipeDetailsPresenter.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

class RecipeDetailsPresenter: RecipeDetailsViewToPresenterProtocal {
    var view: RecipeDetailsViewProtocol?
    var interactor: RecipeDetailsInteractorProtocol?
    var router: RecipeDetailsRouter?

    func fetchRecipeDetails() {
        interactor?.fetchRecipeDetails()
    }
}

extension RecipeDetailsPresenter: RecipeDetailsInteractorToPresenterProtocol {
    func recipeDetailsSuccess(url: String?) {
        DispatchQueue.main.async {
            self.view?.recipeDetailsSuccess(url: url)
        }
    }
}
