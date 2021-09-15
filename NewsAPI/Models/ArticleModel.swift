//
//  ArticleModel.swift
//  NewsAPI
//
//  Created by Tai Chin Huang on 2021/9/15.
//

import Foundation

// 自訂protocol
protocol ArticleModelProtocol {
    func articlesRetrieved(_ articles: [Article])
}

class ArticleModel {
    var delegate: ArticleModelProtocol?
    
    func fetchArticles() {
        /*
         1. 先將欲抓取的連結存在urlString裏
         2. 利用URL(string:)轉換成URL
         3. URLSession.shared.dataTask開始建立任務
         4. 解析需要使用JSONDecoder()
         5. 確保有寫入解析失敗可用do catch
         6. 將解析完的資料先儲存在一個常數(或直接指派給一個你要用的常數)
        */
        let urlString = "https://newsapi.org/v2/top-headlines?country=tw&apiKey=bc8673d62d5e4a989020a3884354186f"
        guard let url = URL(string: urlString) else {
            fatalError("Fail to fetch JSON data")
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let articlesResponse = try decoder.decode(ArticleMain.self, from: data)
                    let articles = articlesResponse.articles
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles!)
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
