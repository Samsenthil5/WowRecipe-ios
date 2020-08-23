//
//  RecipeListViewController.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import UIKit

class RecipeListViewController: UICollectionViewController {
    var presenter: RecipeListViewToPresenterProtocol?
    var recipeLists: [RecipeListModel]? = []
    var estimateCellWidth = 150
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter?.fetchRecipeData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackBarItem()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.convertHexToColor(
            hex: CustomColor.navigationBarTintColor)
        title = (presenter?.getRecipeName() ?? "").capitalized + " " + MyAppDetails.navRecipeTitle
        setupRecipeGridView(containerSize: view.frame.size)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRecipeGridView(containerSize: view.frame.size)
    }
    private func setupBackBarItem() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: Icons.backArrow)?.withTintColor(.black, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self, action: #selector(backTapped(_:)))
        self.navigationItem.leftBarButtonItem  = backButton
    }
    @objc private func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - UICollectionViewDataSource
extension RecipeListViewController: MyRecipeCellDelegate {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeLists?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyAppDetails.receipeCellIdentifier, for: indexPath) as? MyRecipeCell else {
                return UICollectionViewCell()
        }
        cell.configureRecipes(recipeList: recipeLists, indexPath: indexPath, presenter: presenter)
        cell.delegate = self
        return cell
    }
    // MARK: - Shop Recipe
    func shopRecipeAction(cell: MyRecipeCell, indexPath: IndexPath) {
        if let list = recipeLists {
            let detailUrl = list[indexPath.row].href ?? ""
            dLog(detailUrl)
            presenter?.setRecipeDetail(recipeDetailUrl: detailUrl)
        }
        guard let navController = navigationController else {
            return
        }
        presenter?.pushToNextViewController(navigationController: navController)
    }
}
extension RecipeListViewController {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellItemSize(containerSize: view.frame.size)
    }
    func setupRecipeGridView(containerSize: CGSize) {
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = getCellItemSize(containerSize: containerSize)
        flowLayout.sectionInset = .zero
    }
    func getCellItemSize(containerSize: CGSize) -> CGSize {
        let numberOfCell = containerSize.width / CGFloat(estimateCellWidth)
        let width = floor((numberOfCell / floor(numberOfCell)) * CGFloat(estimateCellWidth))
        let height = ceil(width * (4.0 / 3.0))
        return CGSize(width: width, height: height)
    }
}

// MARK: - Get Recipe Data
extension RecipeListViewController: RecipeListViewProtocol {
    func recipeDataSuccess(recipeList: [RecipeListModel]?) {
        self.recipeLists = recipeList
        collectionView.reloadData()
    }
}
