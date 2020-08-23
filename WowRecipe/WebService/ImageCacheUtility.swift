//
//  ImageCacheUtility.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/22/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

var asyncCacheImages = NSCache<AnyObject, UIImage>()
private var selectedURL: String?
class ImageCacheUtility {
    /// get Recipe thumbnail image from server
    /// - Parameters:
    ///   - url: Recipe thumbnail url
    ///   - onCompletion: service callbacks(Success, Failure)
    static func getRecipeImageFromServer(
        url: String,
        onCompletion: @escaping (_ response: UIImage?, _ success: Error?) -> Void) {
        let imageURL = loadCacheImage(url: url, onCompletion: onCompletion)
        guard let requestURL = URL(string: url) else {
            onCompletion(nil, RecipeError.serviceError)
            return
        }
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.imageLoadingSuccess(imageURL: imageURL, data: data, error: error, onCompletion: onCompletion)
                } else {
                    onCompletion(nil, error)
                    return
                }
            }
        }.resume()
    }
    /// Load Cache image
    /// - Parameters:
    ///   - url: Recipe thumbnail url
    ///   - onCompletion: service callbacks(Success, Failure)
    /// - Returns: Image Url
    static func loadCacheImage(url: String,
                               onCompletion: @escaping (_ response: UIImage?, _ success: Error?) -> Void) -> String {
        if let cashedImage = asyncCacheImages.object(forKey: url as AnyObject) {
            onCompletion(cashedImage, nil)
            return ""
        }
        selectedURL = url
        return url
    }
    /// Image Loading Success callback
    /// - Parameters:
    ///   - imageURL: Recipe Image Url
    ///   - data: Image Data
    ///   - error: Error
    ///   - onCompletion: service callbacks(Success, Failure)
    static func imageLoadingSuccess(imageURL: String,
                                    data: Data?,
                                    error: Error?,
                                    onCompletion: @escaping (_ response: UIImage?, _ success: Error?) -> Void) {
        if let imageData = data {
            if selectedURL == imageURL {
                if let imageToPresent = UIImage(data: imageData) {
                    asyncCacheImages.setObject(imageToPresent, forKey: imageURL as AnyObject)
                    onCompletion(imageToPresent, nil)
                    return
                } else {
                    onCompletion(nil, error)
                    return
                }
            }
        } else {
            onCompletion(nil, error)
            return
        }
    }
}
