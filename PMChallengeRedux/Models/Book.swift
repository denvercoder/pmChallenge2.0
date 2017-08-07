//
//  Book.swift
//  PMChallengeRedux
//
//  Created by Timothy Myers on 8/6/17.
//  Copyright © 2017 Denver Coder. All rights reserved.
//

import Foundation

struct Book {
    let title: String
    let author: String
    let imageURL: String
    
    enum SerializationError: Error {
        case missingData(String)
    }
    
    init(json: [String: Any]) throws {
        guard let title = json["title"] as? String else {
            throw SerializationError.missingData("Title Not Found")
        }
        guard let author = json["author"] as? String else {
            throw SerializationError.missingData("Author Not Found")
        }
        guard let imageURL = json["type"] as? String else {
            throw SerializationError.missingData("ImageURL Not Found")
        }
        self.title = title
        self.author = author
        self.imageURL = imageURL
        
    }
    
    static let urlString = "https://de-coding-test.s3.amazonaws.com/books.json"
    
    static func getBooks(completion: @escaping ([Book]) -> Void) {
        
        let url = URL(string: urlString)
        print(url!)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [[String: Any]]
                    print(parsedData)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
