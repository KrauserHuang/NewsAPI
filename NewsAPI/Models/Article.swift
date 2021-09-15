//
//  Article.swift
//  NewsAPI
//
//  Created by Tai Chin Huang on 2021/9/15.
//

import Foundation

struct ArticleMain: Codable {
    var totalResults: Int?
    var articles: [Article]?
}

struct Article: Codable {
    var author: String?
    var title: String
    var description: String
    var url: String
    var urlToImage: String?
    var publishedAt: String
}
