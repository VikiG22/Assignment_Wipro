//
//  FactsViewModel.swift
//  Assignment_VikramGupta
//
//  Created by Vikram Gupta on 7/23/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import Foundation

class FactsViewModel: NSObject {
    private var facts: Facts?
    
    // Get Fact Row for given index
    func getRow(at index: Int) -> Row? {
        let rows  = facts?.rows?.filter { row in
            return (row.title != nil || row.description != nil) }
        return rows?[index]
    }
    
    //get title of the Scrren
    func getTitle() -> String? {
        return facts?.title
    }
    
    // Number of Facts Items
    func numberOfRows() -> Int? {
        let items  = facts?.rows?.filter { row in
            return (row.title != nil || row.description != nil) }
        return items?.count
    }
    
    //MARK: API CALL
    func requestData(apiName: ApiName, completionHandler: @escaping (_ result: Bool, _ error: ApiError?) -> Void){
        ApiManager.shared.apiRequest(apiName: apiName) { [weak self] result in
            switch result{
            case .success(let data):
                do {
                    let deacoder = JSONDecoder()
                    deacoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonString = String(data: data, encoding: .ascii)
                    guard let newData = jsonString?.data(using: .utf8) else {
                        return
                    }
                    let json = try deacoder.decode(Facts.self, from: newData)
                    self?.facts = json
                    completionHandler(true, nil)
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                    completionHandler(false, .parsingError)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(false, .networkNotAvilable)
            }
        }
    }
}
