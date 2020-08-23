//
//  RecipeDetailsRouter.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

class RecipeDetailsRouter: RecipeDetaillsRouterProtocol {
    static func createRecipeDetails() -> RecipeDetailsViewController? {
        guard let view = storyboard(name: StoryBoardName.recipeDetailsVC).instantiateViewController(
            withIdentifier: StoryBoardIdentifier.recipeDetailsVC) as? RecipeDetailsViewController else {
            return nil
        }
        let interactor: RecipeDetailsInteractorProtocol = RecipeDetailsInteractor()
        let presenter: RecipeDetailsViewToPresenterProtocal &
            RecipeDetailsInteractorToPresenterProtocol = RecipeDetailsPresenter()
        let router: RecipeDetaillsRouterProtocol = RecipeDetailsRouter()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router as? RecipeDetailsRouter
        return view
    }
    static func storyboard(name: String, bundle: Bundle = Bundle.main) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: bundle)
    }
}
