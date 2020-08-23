//
//  SearchRecipeRouter.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

class SearchRecipeRouter: SearchRecipeRouterProtocol, RecipeListRouterProtocol {
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

    static func createSearchRecipe() -> SearchRecipeViewController? {
        guard let view = storyboard(name: StoryBoardName.searchRecipeVC).instantiateViewController(
            withIdentifier: StoryBoardIdentifier.searchRecipeVC) as? SearchRecipeViewController else {
            return nil
        }
        let interactor: SearchRecipeInteractorProtocol = SearchRecipeInteractor()
        let presenter: SearchRecipeViewToPresenterProtocol &
            SearchRecipeInteractorToPresenterProtocol = SearchRecipePresenter()
        let router: SearchRecipeRouterProtocol = SearchRecipeRouter()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router as? SearchRecipeRouter
        return view
    }
    static func storyboard(name: String, bundle: Bundle = Bundle.main) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: bundle)
    }
    func pushToNextViewController(navigationController: UINavigationController) {
        guard let recipeListVC = SearchRecipeRouter.createRecipeList() else {
            return
        }
        navigationController.pushViewController(recipeListVC, animated: true)
    }
}
