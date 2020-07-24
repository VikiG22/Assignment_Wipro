//
//  APIManager.swift
//  Assignment_VikramGupta
//
//  Created by Vikram Gupta on 7/23/20.
//  Copyright © 2020 Vikram Gupta. All rights reserved.
//

import UIKit
 
class ApiManager: NSObject {
    
    static let shared = ApiManager()
    
    func apiRequest(apiName: ApiName, completionHandler: @escaping (Result<Data, ApiError>) -> Void){
        if NetworkManager.isNetworkAvailable() {
            let session = URLSession.shared
            let url = URL(string: (baseURL+"\(apiName.rawValue)").addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!
                    
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                // Check the response
                if let data = data {
                    completionHandler(.success(data))
                }else{
                    completionHandler(.failure(.inValidResponse))
                }
            })
            task.resume()
        } else {
            completionHandler(.failure(.networkNotAvilable))
        }
    }
}
