//
//  MyBaseUnitTests.swift
//  WowRecipeTests
//
//  Created by Senthilmurugan on 8/22/20.
//  Copyright © 2020 Senthilmurugan. All rights reserved.
//

import XCTest

@testable import Wow_Recipe

struct MockData {
    static let searchTxt = "onion"
    static let errorMsg = "Testing Error"
}
let stubTimeOut = 5.0
class MyBaseUnitTests: XCTestCase {
    func asyncWaitForStubServiceCalls() {
        let exp = expectation(description: "Async wait for stub data")
        let result = XCTWaiter.wait(for: [exp], timeout: stubTimeOut)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(true)
        } else {
            XCTFail("Got error in async wait. Abort test")
        }
    }
    func getMockData() -> [RecipeListModel]? {
        guard let url = Bundle.main.url(forResource: "recipeMockData", withExtension: "json") else {
            return nil
        }
        do {
            var json: Any?
            // Getting data from JSON file using the file URL
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let jsonResult = json as? [String: Any] {
                // do stuff
                guard let results = jsonResult[ResponseKeyNames.searchResultKey.rawValue] as? [Any] else {
                    return nil
                }
                //Parse the Json
                guard let jsonData = Utils.convertDataFromJSON(json: results as AnyObject) else {
                    return nil
                }
                guard let recipeDataModel = try? JSONDecoder().decode(
                    [RecipeListModel].self, from: jsonData) else {
                        return nil
                }
                return recipeDataModel
            }
        } catch {
            dLog("Pairing failure")
        }
        return nil
    }
    func getRecipeImageMockUrl() -> String {
        let mockData = getMockData()
        return mockData?.first?.thumbnail ?? ""
    }
    func getRecipeDetailMockUrl() -> String {
        let mockData = getMockData()
        return mockData?.first?.href ?? ""
    }
}
