//
//  RecipeDetailsTests.swift
//  WowRecipeTests
//
//  Created by Senthilmurugan on 8/22/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import XCTest
@testable import WowRecipe

class RecipeDetailsTests: MyBaseUnitTests {
    var recipeDetailsVC: RecipeDetailsViewController!

    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: StoryBoardName.recipeDetailsVC, bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(
            withIdentifier: StoryBoardIdentifier.recipeDetailsVC) as? RecipeDetailsViewController else {
            XCTFail("RecipeDetailsViewController could not be instantiated.")
            return
        }
        recipeDetailsVC = viewController
    }

    override func tearDown() {
        super.tearDown()
        recipeDetailsVC.endAppearanceTransition()
        recipeDetailsVC = nil
    }
    func testRecipeDetailsPresenter() {
        let viewSpy = RecipeDetailsViewSpy()
        let interactorSpy = RecipeDetailsInteractorSpy()
        let presenterSpy = RecipeDetailsPresenter()
        let router = RecipeDetailsRouter()
        presenterSpy.view = viewSpy
        presenterSpy.interactor = interactorSpy
        presenterSpy.router = router

        // Presenter to Router
        _ = RecipeDetailsRouter.createRecipeDetails()

        // Presenter to Interactor
        presenterSpy.fetchRecipeDetails()
        XCTAssertTrue(interactorSpy.fetchRecipeDetailsPassed)
        presenterSpy.recipeDetailsSuccess(url: getRecipeDetailMockUrl())
        XCTAssertTrue(interactorSpy.fetchRecipeDetailsPassed)
    }

    func testRecipeDetailsInteractor() {
        let presenterSpy = RecipeDetailsPresenterSpy()
        let interactorSpy =  RecipeDetailsInteractor()
        interactorSpy.presenter = presenterSpy

        interactorSpy.fetchRecipeDetails()
        presenterSpy.recipeDetailsSuccess(url: getRecipeDetailMockUrl())
        XCTAssertTrue(presenterSpy.recipeDetailsSuccessPassed)
    }

    func testRecipeDetailsViewController() {
        let presenterSpy = RecipeDetailsPresenterSpy()
        recipeDetailsVC.presenter = presenterSpy
        recipeDetailsVC.loadViewIfNeeded()
        recipeDetailsVC.beginAppearanceTransition(true, animated: false)

        presenterSpy.fetchRecipeDetails()
        XCTAssertTrue(presenterSpy.fetchRecipeDetailsPassed)

        recipeDetailsVC.recipeDetailsSuccess(url: getRecipeDetailMockUrl())
    }
}
class RecipeDetailsPresenterSpy: RecipeDetailsViewToPresenterProtocal, RecipeDetailsInteractorToPresenterProtocol {
    var recipeDetailsSuccessPassed = false
    var view: RecipeDetailsViewProtocol?
    var interactor: RecipeDetailsInteractorProtocol?
    var router: RecipeDetailsRouter?
    var fetchRecipeDetailsPassed = false
    var pushToNextViewControllerPassed = false
    func recipeDetailsSuccess(url: String?) {
        recipeDetailsSuccessPassed = true
    }
    func fetchRecipeDetails() {
        fetchRecipeDetailsPassed = true
    }
}
class RecipeDetailsInteractorSpy: RecipeDetailsInteractorProtocol {
    var presenter: RecipeDetailsInteractorToPresenterProtocol?
    var fetchRecipeDetailsPassed = false
    func fetchRecipeDetails() {
        fetchRecipeDetailsPassed = true
    }

}

class RecipeDetailsViewSpy: RecipeDetailsViewProtocol {
    var recipeDetailsSuccessPassed = false
    func recipeDetailsSuccess(url: String?) {
        recipeDetailsSuccessPassed = true
    }
}
class RecipeDetailsRouterSpy: RecipeDetaillsRouterProtocol {
    static func createRecipeDetails() -> RecipeDetailsViewController? {
        guard let view = UIStoryboard(name: StoryBoardName.recipeDetailsVC,
                                      bundle: Bundle.main).instantiateViewController(
            withIdentifier: StoryBoardIdentifier.recipeDetailsVC) as? RecipeDetailsViewController else {
                return nil
        }
        return view
    }
}
