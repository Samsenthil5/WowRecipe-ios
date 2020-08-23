//
//  RecipeError.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/22/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

enum RecipeError: Error {
    static let serviceErrorMessage = "Response Not Found"
    static let incorrectResponseMessage = "Incorrect reponse received from service, jsonData is not correct"
    static let decodeMessage = "Couldn't able to decode data"
    static let unauthorizedMessage = "A System Error has occurred while processing the request"
    case serviceError
    case incorrectResponse
    case decodeError
    case unauthorized
}
extension RecipeError {
    public var localizedDescription: String {
        switch self {
        case .serviceError:
            return RecipeError.serviceErrorMessage
        case .incorrectResponse:
            return RecipeError.incorrectResponseMessage
        case .decodeError:
            return RecipeError.decodeMessage
        case .unauthorized:
            return RecipeError.unauthorizedMessage
        }
    }
}
