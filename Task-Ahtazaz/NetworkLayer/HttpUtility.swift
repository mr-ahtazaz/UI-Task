//
//  HttpUtility.swift
//  Knipklok_v1
//
//  Created by Ahtazaz Khan on 5/4/20.
//  Copyright © 2020 SD. All rights reserved.
//

import Foundation
 
class HttpUtility {
    
    func getAPI<T: Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(Result<T, AKError>) -> Void)  {
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            
//            print("JSON_RESPONSE")
//            if let resData = responseData {
//                let jsonResponse = try? JSONSerialization.jsonObject(with: resData, options:.mutableContainers)
//                print(jsonResponse ?? "")
//            }
//            print("==================== POST API Request END=============")
            
            if let _ = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.unableToComplete))
                }
                return
            }
            
            guard let response = httpUrlResponse as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = responseData  else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.invalidData))
                }
                return
            }
            
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(.invalidData))
                }
            }
            
        }.resume()
    }
    
}
