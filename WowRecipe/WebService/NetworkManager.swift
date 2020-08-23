//
//  NetworkManager.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/21/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation

public typealias Dictionary = [String: Any]
public typealias ResponseHandler = (URLResponse?, Dictionary?, Error? ) -> Void

class NetworkManager {
    /// Get Response from Server
    /// - Parameters:
    ///   - responseKey: response results key
    ///   - requestBody: request body
    ///   - requestURL: server url
    ///   - httpMethodType: http method type (Get, Post, Put, Delete)
    ///   - onCompletion: service callbacks(Success, Failure)
    static func getResponseFromServer(responseKey: ResponseKeyNames,
                                      requestBody: [String: Any]? = nil,
                                      requestURL: String?,
                                      httpMethodType: HTTPMethodType,
                                      onCompletion: @escaping (_ response: Any?, _ success: Error?) -> Void) {
        dLog("serviceURL \(String(describing: requestURL))")
        getResponseData(httpBodyDict: requestBody,
                             serviceURL: requestURL,
                             httpMethodType: httpMethodType) { (_, responseObject, error) in
                                // Error occured
                                if  error != nil {
                                    onCompletion(nil, error)
                                    return
                                }
                                // Response Success
                                dLog("Success in response \(String(describing: responseObject))")
                                guard let root: Dictionary =
                                    responseObject,
                                    let response: Any = root[responseKey.rawValue]
                                    else {
                                        onCompletion(nil, RecipeError.serviceError)
                                        return
                                }
                                onCompletion(response, nil)
        }
    }
    /// Get Response Data from Server
    /// - Parameters:
    ///   - httpBodyDict: request body
    ///   - serviceURL: server url
    ///   - httpMethodType: http method type (Get, Post, Put, Delete)
    ///   - onCompletion: service callbacks(Success, Failure)
    static func getResponseData(httpBodyDict: [String: Any]? = nil,
                                serviceURL: String?,
                                httpMethodType: HTTPMethodType, onCompletion: @escaping ResponseHandler) {
        guard let url = URL(string: serviceURL ?? "") else {
            return
        }
        let requestHeaderData = getHeaders()
        var clientRequest = URLRequest(url: url)
        clientRequest.httpMethod = httpMethodType.rawValue
        clientRequest.allHTTPHeaderFields = requestHeaderData as? [String: String]
        URLSession.shared.dataTask(with: clientRequest) { (data, response, error) in
            if let error = error {
                onCompletion(response as? HTTPURLResponse, nil, error as NSError?)
                return
            }
            do {
                if let data = data,
                    let jsonResponse = try JSONSerialization.jsonObject(with: data,
                                                                        options: .allowFragments) as? Dictionary {
                    if let realResponse = response as? HTTPURLResponse {
                        let httpStatusCode = realResponse.statusCode
                        if httpStatusCode == 200 {
                            onCompletion(realResponse, jsonResponse, nil)
                        } else {
                            onCompletion(realResponse, jsonResponse, RecipeError.unauthorized)
                        }
                    }
                }
            } catch let error as NSError {
                onCompletion(response as? HTTPURLResponse, nil, error)
            }
        }.resume()
    }
    /// Response Handler
    /// - Parameters:
    ///   - response: response data
    ///   - onCompletion: service callbacks(Success, Failure)
    static func responseHandler(response: Any?,
                                onCompletion: @escaping (_ response: Data?, _ success: Error?) -> Void) {
        guard let response: Any = response else {
            onCompletion(nil, RecipeError.incorrectResponse)
            return
        }
        guard let jsonData = Utils.convertDataFromJSON(json: response as AnyObject) else {
            onCompletion(nil, RecipeError.incorrectResponse)
            return
        }
        onCompletion(jsonData, nil)
    }
    /// Request Header
    /// - Returns: get request header dictionay value
    static func getHeaders() -> Dictionary {
        let headers = [Server.contentTypeKey: Server.requestContentNAcceptType,
                       Server.acceptKey: Server.requestContentNAcceptType]
        return headers as Dictionary
    }
    static func decodeError() -> Error {
        return RecipeError.decodeError
    }
}
