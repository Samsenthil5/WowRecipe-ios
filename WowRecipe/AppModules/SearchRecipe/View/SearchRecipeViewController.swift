//
//  SearchRecipeViewController.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UIViewController {
    var presenter: SearchRecipeViewToPresenterProtocol?
    @IBOutlet weak var searchRecipeTxt: UITextField!
    @IBOutlet weak var searchRecipeLoadingAnimator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(resignKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    // MARK: - Search Recipe
    @IBAction func onClickSearchRecipe(_ sender: Any) {
        if searchRecipeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            searchRecipeLoadingAnimator.startAnimating()
            searchRecipeLoadingAnimator.isHidden = false
            searchRecipeTxt.resignFirstResponder()
            presenter?.fetchRecipeData(searchRecipeTxt: searchRecipeTxt.text ?? "")
        } else {
            Utils.showAlertView(title: CustomAlert.errorTitle,
                                message: CustomAlert.enterRecipeMessage,
                                viewController: self,
                                okTapped: {})
        }
    }
    @objc
    func resignKeyboard() {
        view.endEditing(true)
    }
}
// MARK: - Fetch Recipes
extension SearchRecipeViewController: SearchRecipeViewProtocol {
    func fetchRecipeDataSuccess(recipeLists: [RecipeListModel]?) {
        searchRecipeLoadingAnimator.stopAnimating()
        if recipeLists?.isEmpty ?? false {
            Utils.showAlertView(title: CustomAlert.infoTitle,
                                message: CustomAlert.recipeNotFoundMessage,
                                viewController: self,
                                okTapped: {})
            return
        }
        guard let navController = navigationController else {
            return
        }
        presenter?.pushToNextViewController(navigationController: navController)
    }
    func fetchRecipeDataFailure(errorMessage: String) {
        searchRecipeLoadingAnimator.stopAnimating()
        Utils.showAlertView(title: CustomAlert.errorTitle, message: errorMessage, viewController: self, okTapped: {})
    }
}
