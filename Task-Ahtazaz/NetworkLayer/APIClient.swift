//
//  APIClient.swift
//  Knipklok_v1
//
//  Created by Ahtazaz Khan on 5/4/20.
//  Copyright © 2020 SD. All rights reserved.
//

import Foundation

class APIClient {
    
    private let httpUtility : HttpUtility
    
    init(_httpUtility: HttpUtility) {
        httpUtility = _httpUtility
    }
    
    // MARK:-  Login
    func ahtazazTask(request: String, completionHandler: @escaping(Result<TaskModel, AKError>) -> Void) {
        
        httpUtility.getAPI(requestUrl: URL(string: request)!, resultType: TaskModel.self)
        { result in
            
            switch result {
            case .success(let responseData) :
                completionHandler(.success(responseData))
                
            case .failure(let error) :
                completionHandler(.failure(error))
            }
        }
        
    }
    
}
