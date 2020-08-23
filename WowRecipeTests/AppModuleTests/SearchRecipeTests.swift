//
//  SearchRecipeTests.swift
//  WowRecipeTests
//
//  Created by Senthilmurugan on 8/22/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import XCTest
@testable import WowRecipe
class SearchRecipeTests: MyBaseUnitTests {
    var searchRecipeVC: SearchRecipeViewController!

    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: StoryBoardName.searchRecipeVC, bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(
            withIdentifier: StoryBoardIdentifier.searchRecipeVC) as? SearchRecipeViewController else {
            XCTFail("SearchRecipeViewController could not be instantiated.")
            return
        }
        searchRecipeVC = viewController
    }

    override func tearDown() {
        super.tearDown()
        searchRecipeVC.endAppearanceTransition()
        searchRecipeVC = nil
    }
    func testSearchRecipePresenter() {
        let viewSpy = SearchRecipeViewSpy()
        let interactorSpy = SearchRecipeInteractorSpy()
        let routerSpy = SearchRecipeRouterSpy()
        let presenterSpy = SearchRecipePresenter()
        let router = SearchRecipeRouter()
        presenterSpy.view = viewSpy
        presenterSpy.interactor = interactorSpy
        presenterSpy.router = router

        // Presenter to Interactor
        interactorSpy.fetchRecipeData(searchRecipeTxt: MockData.searchTxt)
        XCTAssertTrue(interactorSpy.fetchRecipeDataPassed)

        presenterSpy.fetchRecipeData(searchRecipeTxt: MockData.searchTxt)
        presenterSpy.fetchRecipeDataSuccess(recipeLists: getMockData())
        presenterSpy.fetchRecipeDataFailure(errorMessage: MockData.errorMsg)
        XCTAssertTrue(interactorSpy.fetchRecipeDataPassed)

        // Presenter to Router
        let nav = UINavigationController()
        router.pushToNextViewController(navigationController: nav)
        _ = SearchRecipeRouter.createRecipeList()
        _ = SearchRecipeRouter.createSearchRecipe()
        routerSpy.pushToNextViewController(navigationController: nav)
        XCTAssertTrue(routerSpy.pushToNextViewControllerPassed)

        // Presenter to View
        let mockData = getMockData()
        viewSpy.fetchRecipeDataSuccess(recipeLists: mockData)
        XCTAssertTrue(viewSpy.fetchRecipeDataSuccessPassed)
        viewSpy.fetchRecipeDataFailure(errorMessage: MockData.errorMsg)
        XCTAssertTrue(viewSpy.fetchRecipeDataFailurePassed)
    }

    func testSearchRecipeInteractor() {
        let presenterSpy = SearchRecipePresenterSpy()
        let interactorSpy =  SearchRecipeInteractor()
        interactorSpy.presenter = presenterSpy

        interactorSpy.fetchRecipeData(searchRecipeTxt: MockData.searchTxt)
        // Success
        let mockData = getMockData()
        presenterSpy.fetchRecipeDataSuccess(recipeLists: mockData)
        XCTAssertTrue(presenterSpy.fetchRecipeDataSuccessPassed)
        // Failure
        presenterSpy.fetchRecipeDataFailure(errorMessage: MockData.errorMsg)
        XCTAssertTrue(presenterSpy.fetchRecipeDataFailurePassed)
        asyncWaitForStubServiceCalls()
        _ = SearchRecipeServiceUtility.getRecipeListFromServer(searchRecipeStr: MockData.searchTxt,
                                                               completion: { (_, _) in

        })
    }

    func testSearchRecipeViewController() {
        let presenterSpy = SearchRecipePresenterSpy()
        searchRecipeVC.presenter = presenterSpy
        searchRecipeVC.loadViewIfNeeded()
        searchRecipeVC.beginAppearanceTransition(true, animated: false)
        let button = UIButton()

        searchRecipeVC.searchRecipeTxt.text = MockData.searchTxt
        searchRecipeVC.onClickSearchRecipe(button)
        presenterSpy.fetchRecipeData(searchRecipeTxt: MockData.searchTxt)
        XCTAssertTrue(presenterSpy.fetchRecipeDataPassed)

        let mockData = getMockData()
        searchRecipeVC.fetchRecipeDataSuccess(recipeLists: mockData)
        searchRecipeVC.fetchRecipeDataFailure(errorMessage: MockData.errorMsg)
    }
}
class SearchRecipePresenterSpy: SearchRecipeViewToPresenterProtocol, SearchRecipeInteractorToPresenterProtocol {
    var view: SearchRecipeViewProtocol?
    var interactor: SearchRecipeInteractorProtocol?
    var router: SearchRecipeRouter?
    var fetchRecipeDataPassed = false
    var pushToNextViewControllerPassed = false
    var fetchRecipeDataSuccessPassed = false
    var fetchRecipeDataFailurePassed = false

    func fetchRecipeDataSuccess(recipeLists: [RecipeListModel]?) {
        fetchRecipeDataSuccessPassed = true
    }

    func fetchRecipeDataFailure(errorMessage: String) {
        fetchRecipeDataFailurePassed = true
    }
    func fetchRecipeData(searchRecipeTxt: String) {
        fetchRecipeDataPassed = true
    }

    func pushToNextViewController(navigationController: UINavigationController) {
        pushToNextViewControllerPassed = true
    }
}

class SearchRecipeInteractorSpy: SearchRecipeInteractorProtocol {
    var presenter: SearchRecipeInteractorToPresenterProtocol?
    var fetchRecipeDataPassed = false
    func fetchRecipeData(searchRecipeTxt: String) {
        fetchRecipeDataPassed = true
    }
}

class SearchRecipeViewSpy: SearchRecipeViewProtocol {
    var fetchRecipeDataSuccessPassed = false
    var fetchRecipeDataFailurePassed = false
    func fetchRecipeDataSuccess(recipeLists: [RecipeListModel]?) {
        fetchRecipeDataSuccessPassed = true
    }
    func fetchRecipeDataFailure(errorMessage: String) {
        fetchRecipeDataFailurePassed = true
    }
}
class SearchRecipeRouterSpy: SearchRecipeRouterProtocol {
    var pushToNextViewControllerPassed = false
    static func createSearchRecipe() -> SearchRecipeViewController? {
        guard let view = UIStoryboard(name: StoryBoardName.searchRecipeVC,
                                      bundle: Bundle.main).instantiateViewController(
            withIdentifier: StoryBoardIdentifier.searchRecipeVC) as? SearchRecipeViewController else {
                return nil
        }
        return view
    }

    func pushToNextViewController(navigationController: UINavigationController) {
        pushToNextViewControllerPassed = true
    }
}
