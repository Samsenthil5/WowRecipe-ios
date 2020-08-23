//
//  RecipeDetailsInteractorProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

protocol RecipeDetailsInteractorProtocol: class {
    var presenter: RecipeDetailsInteractorToPresenterProtocol? {get set}
    func fetchRecipeDetails()
}
