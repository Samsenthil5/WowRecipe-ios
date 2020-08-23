//
//  RecipeDetailsViewController.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import UIKit
import WebKit

class RecipeDetailsViewController: UIViewController, WKNavigationDelegate {
    var presenter: RecipeDetailsViewToPresenterProtocal?
    @IBOutlet weak var recipeDetailWebview: WKWebView!
    @IBOutlet weak var loadingRecipeDetailsAnimator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recipeDetailWebview.navigationDelegate = self
        navigationController?.navigationBar.barTintColor = UIColor.convertHexToColor(
            hex: CustomColor.navigationBarTintColor)
        loadingRecipeDetailsAnimator.startAnimating()
        presenter?.fetchRecipeDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackBarItem()
        navigationController?.isNavigationBarHidden = false
        title = MyAppDetails.navRecipeDetailTitle
    }
    private func setupBackBarItem() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: Icons.backArrow)?.withTintColor(.black, renderingMode: .alwaysOriginal),
            style: .plain, target: self,
            action: #selector(backTapped(_:)))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    @objc private func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension RecipeDetailsViewController: RecipeDetailsViewProtocol {
    // MARK: - Recipe Details
    func recipeDetailsSuccess(url: String?) {
        guard let urlString = url else {
            return
        }
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            recipeDetailWebview.load(request)
        }
    }
}
extension RecipeDetailsViewController {
    // MARK: - Recipe WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingRecipeDetailsAnimator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingRecipeDetailsAnimator.stopAnimating()
    }
}
