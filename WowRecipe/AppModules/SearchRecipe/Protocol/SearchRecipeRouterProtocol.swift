//
//  SearchRecipeRouterProtocol.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

protocol SearchRecipeRouterProtocol: class {
    static func createSearchRecipe() -> SearchRecipeViewController?
    func pushToNextViewController(navigationController: UINavigationController)
}
