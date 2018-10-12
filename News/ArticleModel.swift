//
//  ArticleModel.swift
//  News
//
//  Created by Vitaliy Kurbatov on 13/02/2018.
//  Copyright © 2018 Vitaliy Kurbatov. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        // KEYS
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey="
        let key = "2a28f4b7302646a6a2eb2b0c870552e2"
        let url = URL(string: stringUrl + key)
       
        guard url != nil else {
            print("can't create url object")
            return
        }

        let session = URLSession.shared
        
        //create the DataTask object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                do {
                    
                    let  decoder = JSONDecoder()
                    let result = try
                        decoder.decode(ArticleService.self, from: data!)
                    let articles = result.articles!
                    
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                    }
                }
                catch {
                    print("cant decode JSON")
                    return
                }
            }
        }
        dataTask.resume()
    }
}
