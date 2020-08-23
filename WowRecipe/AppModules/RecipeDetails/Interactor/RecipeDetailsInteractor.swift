//
//  RecipeDetailsInteractor.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

class RecipeDetailsInteractor: RecipeDetailsInteractorProtocol {
    var presenter: RecipeDetailsInteractorToPresenterProtocol?

    func fetchRecipeDetails() {
        presenter?.recipeDetailsSuccess(url: RecipeDetailsEntity.recipeDetailUrl ?? "")
    }
}
