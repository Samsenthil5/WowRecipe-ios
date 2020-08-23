//
//  SearchRecipeEntity.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

struct RecipeListModel: Codable {
    var title: String?
    var href: String?
    var ingredients: String?
    var thumbnail: String?
}

class SearchRecipeEntity {
    static var recipeResultLists: [RecipeListModel]?
}
