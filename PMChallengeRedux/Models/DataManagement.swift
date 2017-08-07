//
//  DataManagement.swift
//  PMChallengeRedux
//
//  Created by Timothy Myers on 8/7/17.
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import Foundation

public class DataManager {
    
    public class func getJSONFromURLWithSuccess(success: @escaping ((_ data: Data) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let filePath = Bundle.main.path(forResource: "topapps", ofType:"json")
            let data = try! Data(contentsOf: URL(fileURLWithPath:filePath!), options: .uncached)
            
            success(data)
        }
    }
    
    public class func loadDataFromURL(url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let loadDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil, error)
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    let statusError = NSError(domain: "com.raywenderlich",
                                              code: response.statusCode,
                                              userInfo: [NSLocalizedDescriptionKey: "HTTP status code has unexpected value."])
                    completion(nil, statusError)
                } else {
                    completion(data, nil)
                }
            }
        }
        loadDataTask.resume()
    }
}
