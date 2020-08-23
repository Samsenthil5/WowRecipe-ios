//
//  SearchRecipeViewProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

protocol SearchRecipeViewProtocol: class {
    func fetchRecipeDataSuccess(recipeLists: [RecipeListModel]?)
    func fetchRecipeDataFailure(errorMessage: String)
}
