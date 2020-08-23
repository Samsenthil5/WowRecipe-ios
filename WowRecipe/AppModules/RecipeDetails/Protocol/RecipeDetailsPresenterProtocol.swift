//
//  RecipeDetailsPresenterProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeDetailsViewToPresenterProtocal: class {
    var view: RecipeDetailsViewProtocol? {get set}
    var interactor: RecipeDetailsInteractorProtocol? {get set}
    var router: RecipeDetailsRouter? {get set}
    func fetchRecipeDetails()
}

protocol RecipeDetailsInteractorToPresenterProtocol: class {
    func recipeDetailsSuccess(url: String?)
}
