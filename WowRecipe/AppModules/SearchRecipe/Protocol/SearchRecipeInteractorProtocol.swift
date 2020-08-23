//
//  SearchRecipeInteractorProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

protocol SearchRecipeInteractorProtocol: class {
    var presenter: SearchRecipeInteractorToPresenterProtocol? {get set}
    func fetchRecipeData(searchRecipeTxt: String)
}
