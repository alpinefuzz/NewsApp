//
//  ArticleService.swift
//  News
//
//  Created by Vitaliy Kurbatov on 13/02/2018.
//  Copyright © 2018 Vitaliy Kurbatov. All rights reserved.
//

import Foundation

struct ArticleService : Decodable {
    
    var totalResults:Int?
    var articles:[Article]?
}
