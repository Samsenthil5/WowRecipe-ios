//
//  Utils.swift
//  WowRecipe
//
//  Created by Senthilmurugan on 8/21/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Debug log
#if DEBUG
func dLog(_ message: Any,
          filename: String = #file,
          function: String = #function,
          line: Int = #line) {
    guard let name = NSURL(fileURLWithPath: filename).lastPathComponent else {
        return
    }
    NSLog("[\(name):\(line)] \(function) - \(message)")
}
#else
func dLog(_ : Any,
          _ : String = #file,
          _ : String = #function,
          _ : Int = #line) {
    // Debug Logs
}
#endif

class Utils {
    /// Convert Data from JSON object
    /// - Parameter json: json response object
    /// - Returns: response data
    static func convertDataFromJSON(json: AnyObject) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json,
                                              options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            dLog(myJSONError)
        }
        return nil
    }
    /// Show Alert Message
    /// - Parameters:
    ///   - title: Error Title
    ///   - message: Error Message
    ///   - viewController: ViewController object
    ///   - okTapped: Tab action
    static func showAlertView(title: String, message: String,
                              viewController: UIViewController,
                              okTapped:@escaping () -> Void?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CustomAlert.okTitle,
                                      style: .default) { _ in
                                        okTapped()
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    // Load Main Dispatch Queue
    static func loadViewOnMainQueue(_ excute: @escaping () -> Void) {
        DispatchQueue.main.async(execute: excute)
    }
}
