//
//  RecipeListTests.swift
//  WowRecipeTests
//
//  Created by Senthilmurugan on 8/22/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import XCTest
@testable import Wow_Recipe

class RecipeListTests: MyBaseUnitTests {
    var recipeListVC: RecipeListViewController!
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: StoryBoardName.recipeListVC, bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(
            withIdentifier: StoryBoardIdentifier.recipeListVC) as? RecipeListViewController else {
            XCTFail("RecipeListViewController could not be instantiated.")
            return
        }
        recipeListVC = viewController
    }

    override func tearDown() {
        super.tearDown()
        recipeListVC.endAppearanceTransition()
        recipeListVC = nil
    }
    func testRecipeListPresenter() {
        let viewSpy = RecipeListViewSpy()
        let interactorSpy = RecipeListInteractorSpy()
        let routerSpy = RecipeListRouterSpy()
        let presenterSpy = RecipeListPresenter()
        let router = RecipeListRouter()
        presenterSpy.view = viewSpy
        presenterSpy.interactor = interactorSpy
        presenterSpy.router = router

        let nav = UINavigationController()
        // Presenter to Interactor
        presenterSpy.fetchRecipeData()
        XCTAssertTrue(interactorSpy.fetchRecipeDataPassed)
        presenterSpy.recipeDataSuccess(recipeList: getMockData())
        presenterSpy.setRecipeDetail(recipeDetailUrl: getRecipeDetailMockUrl())
        XCTAssertTrue(interactorSpy.setRecipeDetailPassed)

        // Presenter to Router
        routerSpy.pushToNextViewController(navigationController: nav)
        XCTAssertTrue(routerSpy.pushToNextViewControllerPassed)
        router.pushToNextViewController(navigationController: nav)
        _ = RecipeListRouter.createRecipeList()

        // Presenter to View
        let mockData = getMockData()
        viewSpy.recipeDataSuccess(recipeList: mockData)
        XCTAssertTrue(viewSpy.recipeDataSuccessPassed)
        guard let url = URL(string: getRecipeImageMockUrl()) else {
            return
        }
        presenterSpy.loadRecipeImage(imageURL: url) { (_, _) in
            XCTAssertTrue(interactorSpy.loadRecipeImagePassed)
        }
        _ = presenterSpy.getRecipeName()
        XCTAssertTrue(interactorSpy.getRecipeNamePassed)
    }

    func testRecipeListInteractor() {
        let presenterSpy = RecipeListPresenterSpy()
        let interactorSpy =  RecipeListInteractor()
        interactorSpy.presenter = presenterSpy

        interactorSpy.fetchRecipeData()
        interactorSpy.setRecipeDetail(recipeDetailUrl: getRecipeDetailMockUrl())
        XCTAssertTrue(presenterSpy.recipeDataSuccessPassed)
        guard let url = URL(string: getRecipeImageMockUrl()) else {
            return
        }
        presenterSpy.loadRecipeImage(imageURL: url) { (_, _) in
            XCTAssertTrue(presenterSpy.loadRecipeImagePassed)
        }
        let mockData = getMockData()
        presenterSpy.recipeDataSuccess(recipeList: mockData)
        XCTAssertTrue(presenterSpy.recipeDataSuccessPassed)

        interactorSpy.loadRecipeImage(imageURL: url) { (_, _) in
            XCTAssertTrue(presenterSpy.loadRecipeImagePassed)
        }
        asyncWaitForStubServiceCalls()
        _ = ImageCacheUtility.getRecipeImageFromServer(url: getRecipeImageMockUrl()) { (_, _) in
        }
        _ = interactorSpy.getRecipeName()
    }

    func testRecipeListViewController() {
        let presenterSpy = RecipeListPresenterSpy()
        recipeListVC.presenter = presenterSpy
        recipeListVC.loadViewIfNeeded()
        recipeListVC.beginAppearanceTransition(true, animated: false)

        presenterSpy.fetchRecipeData()
        XCTAssertTrue(presenterSpy.fetchRecipeDataPassed)
        guard let url = URL(string: getRecipeImageMockUrl()) else {
            return
        }
        presenterSpy.loadRecipeImage(imageURL: url) { (_, _) in
            XCTAssertTrue(presenterSpy.loadRecipeImagePassed)
        }

        let indexPath = IndexPath(row: 0, section: 0)
        recipeListVC.recipeLists = getMockData()

        // num of sections
        XCTAssertNotNil(recipeListVC.collectionView.numberOfSections)

        // num of rows in section
        XCTAssertNotNil(recipeListVC.collectionView.numberOfItems(inSection: 0))

        if let cell = recipeListVC.collectionView(recipeListVC.collectionView,
                                                  cellForItemAt: indexPath) as? MyRecipeCell {
            XCTAssertNotNil(cell)
            cell.configureRecipes(recipeList: getMockData(), indexPath: indexPath, presenter: presenterSpy)
            let mockData: [RecipeListModel]? = nil
            cell.configureRecipes(recipeList: mockData, indexPath: indexPath, presenter: presenterSpy)
            cell.delegate?.shopRecipeAction(cell: cell, indexPath: indexPath)
            let button = UIButton()
            cell.onClickShopRecipe(button)
        }
    }

}
class RecipeListPresenterSpy: RecipeListViewToPresenterProtocol, RecipeListInteractorToPresenterProtocol {
    var view: RecipeListViewProtocol?
    var interactor: RecipeListInteractorProtocol?
    var router: RecipeListRouter?
    var fetchRecipeDataPassed = false
    var setRecipeDetailPassed = false
    var loadRecipeImagePassed = false
    var pushToNextViewControllerPassed = false
    var recipeDataSuccessPassed = false
    var getRecipeNamePassed = false
    func fetchRecipeData() {
        fetchRecipeDataPassed = true
    }

    func setRecipeDetail(recipeDetailUrl: String) {
        setRecipeDetailPassed = true
    }

    func loadRecipeImage(imageURL: URL, onCompletion: @escaping (UIImage?, Error?) -> Void) {
        loadRecipeImagePassed = true
    }

    func pushToNextViewController(navigationController: UINavigationController) {
        pushToNextViewControllerPassed = true
    }
    func recipeDataSuccess(recipeList: [RecipeListModel]?) {
        recipeDataSuccessPassed = true
    }
    func getRecipeName() -> String {
        getRecipeNamePassed = true
        return ""
    }
}
class RecipeListInteractorSpy: RecipeListInteractorProtocol {
    var presenter: RecipeListInteractorToPresenterProtocol?
    var fetchRecipeDataPassed = false
    var setRecipeDetailPassed = false
    var loadRecipeImagePassed = false
    var getRecipeNamePassed = false
    func fetchRecipeData() {
        fetchRecipeDataPassed = true
    }

    func setRecipeDetail(recipeDetailUrl: String) {
        setRecipeDetailPassed = true
    }

    func loadRecipeImage(imageURL: URL, onCompletion: @escaping (UIImage?, Error?) -> Void) {
        loadRecipeImagePassed = true
    }
    func getRecipeName() -> String {
        getRecipeNamePassed = true
        return ""
    }
}

class RecipeListViewSpy: RecipeListViewProtocol {
    var recipeDataSuccessPassed = false
    func recipeDataSuccess(recipeList: [RecipeListModel]?) {
        recipeDataSuccessPassed = true
    }
}
class RecipeListRouterSpy: RecipeListRouterProtocol {
    var pushToNextViewControllerPassed = false
    static func createRecipeList() -> RecipeListViewController? {
        guard let view = UIStoryboard(name: StoryBoardName.recipeListVC, bundle: Bundle.main).instantiateViewController(
            withIdentifier: StoryBoardIdentifier.recipeListVC) as? RecipeListViewController else {
                return nil
        }
        return view
    }

    func pushToNextViewController(navigationController: UINavigationController) {
        pushToNextViewControllerPassed = true
    }
}
