//
//  RecipeListRouter.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

class RecipeListRouter: RecipeDetaillsRouterProtocol, RecipeListRouterProtocol {
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

    static func createRecipeList() -> RecipeListViewController? {
        guard let view = storyboard(name: StoryBoardName.recipeListVC).instantiateViewController(
            withIdentifier: StoryBoardIdentifier.recipeListVC) as? RecipeListViewController else {
            return nil
        }
        let interactor: RecipeListInteractorProtocol = RecipeListInteractor()
        let presenter: RecipeListViewToPresenterProtocol &
            RecipeListInteractorToPresenterProtocol = RecipeListPresenter()
        let router: RecipeListRouterProtocol = RecipeListRouter()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router as? RecipeListRouter
        return view
    }
    static func storyboard(name: String, bundle: Bundle = Bundle.main) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: bundle)
    }
    func pushToNextViewController(navigationController: UINavigationController) {
        guard let recipeListVC = RecipeListRouter.createRecipeDetails() else {
            return
        }
        navigationController.pushViewController(recipeListVC, animated: true)
    }
}
