//
//  Constants.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/20/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

// MARK: - Storyboard Name
struct StoryBoardName {
    static let recipeDetailsVC = "RecipeDetails"
    static let recipeListVC = "RecipeList"
    static let searchRecipeVC = "SearchRecipe"
}
// MARK: - Storyboard Identifier
struct StoryBoardIdentifier {
    static let recipeDetailsVC = "RecipeDetailsVC"
    static let recipeListVC = "RecipeListVC"
    static let searchRecipeVC = "SearchRecipeVC"
}
struct CustomColor {
    static let navigationBarTintColor = "FFCC00"
}
struct MyAppDetails {
    static let receipeCellIdentifier = "recipeListCell"
    static let navRecipeTitle = "Recipes"
    static let navRecipeDetailTitle = "Recipe Details"
}

// HTTP Method Types
public enum HTTPMethodType: String {
    case postMethod = "POST"
    case getMethod = "GET"
    case putMethod = "PUT"
    case deleteMethod = "DELETE"
    case patchMethod = "PATCH"
}

// Response Key names
public enum ResponseKeyNames: String {
    case searchResultKey    =   "results"
}

struct Server {
    static let url = "http://www.recipepuppy.com/api/?q="
    static let requestContentNAcceptType = "application/json"
    static let contentTypeKey = "Content-Type"
    static let acceptKey = "Accept"
}

struct CustomAlert {
    static let okTitle = "Ok"
    static let errorTitle = "Error"
    static let infoTitle = "Info"
    static let enterRecipeMessage = "Please enter recipe name"
    static let recipeNotFoundMessage = "Recipe is not found"
}
struct Icons {
    static let backArrow = "chevron.left"
}
