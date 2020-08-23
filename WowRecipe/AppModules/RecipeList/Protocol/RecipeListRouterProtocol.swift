//
//  RecipeListRouterProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

protocol RecipeListRouterProtocol: class {
    static func createRecipeList() -> RecipeListViewController?
    func pushToNextViewController(navigationController: UINavigationController)
}
