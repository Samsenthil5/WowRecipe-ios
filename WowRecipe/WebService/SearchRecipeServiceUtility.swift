//
//  SearchRecipeServiceUtility.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/21/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

class SearchRecipeServiceUtility {
    /// Get Recipe List from Server
    /// - Parameters:
    ///   - searchRecipeStr: search recipe text value
    ///   - completion: service callbacks(Success, Failure)
    static func getRecipeListFromServer(
        searchRecipeStr: String,
        completion: @escaping (_ response: [RecipeListModel]?, _ error: Error?) -> Void) {
        let requestUrl =  (Server.url + searchRecipeStr)
        NetworkManager.getResponseFromServer(
            responseKey: ResponseKeyNames.searchResultKey,
            requestURL: requestUrl,
            httpMethodType: HTTPMethodType.getMethod) { (response, error) in
                if error != nil {
                    completion(nil, error)
                    return
                } else {
                    dLog(response ?? [])
                    NetworkManager.responseHandler(response: response) { (jsonData, error) in
                        if let userInfoServiceErr = error {
                            completion(nil, userInfoServiceErr)
                        } else if let data = jsonData {
                            guard let recipeListJSON = try? JSONDecoder().decode(
                                [RecipeListModel].self, from: data) else {
                                    dLog("Couldn't able to decode data")
                                    completion(nil, NetworkManager.decodeError())
                                    return
                            }
                            completion(recipeListJSON, nil)
                            return
                        }
                    }
                }
        }
    }
}
