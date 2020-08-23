//
//  SearchRecipePresenterProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

protocol SearchRecipeViewToPresenterProtocol: class {
    var view: SearchRecipeViewProtocol? {get set}
    var interactor: SearchRecipeInteractorProtocol? {get set}
    var router: SearchRecipeRouter? {get set}
    func fetchRecipeData(searchRecipeTxt: String)
    func pushToNextViewController(navigationController: UINavigationController)
}

protocol SearchRecipeInteractorToPresenterProtocol: class {
    func fetchRecipeDataSuccess(recipeLists: [RecipeListModel]?)
    func fetchRecipeDataFailure(errorMessage: String)
}
