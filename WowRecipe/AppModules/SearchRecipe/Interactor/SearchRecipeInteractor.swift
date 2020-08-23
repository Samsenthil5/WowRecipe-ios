//
//  SearchRecipeInteractor.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

class SearchRecipeInteractor: SearchRecipeInteractorProtocol {
    var presenter: SearchRecipeInteractorToPresenterProtocol?

    func fetchRecipeData(searchRecipeTxt: String) {
        SearchRecipeServiceUtility.getRecipeListFromServer(searchRecipeStr: searchRecipeTxt) { (recipeLists, error) in
            if let err = error {
                dLog(err.localizedDescription)
                self.presenter?.fetchRecipeDataFailure(errorMessage: err.localizedDescription)
                return
            }
            SearchRecipeEntity.recipeResultLists = recipeLists
            RecipeListEntity.recipeName = searchRecipeTxt
            dLog(SearchRecipeEntity.recipeResultLists ?? [])
            self.presenter?.fetchRecipeDataSuccess(recipeLists: recipeLists)
        }
    }
}
