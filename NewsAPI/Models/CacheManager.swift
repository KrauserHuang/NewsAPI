//
//  CacheManager.swift
//  NewsAPI
//
//  Created by Tai Chin Huang on 2021/9/15.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String : Data]()
    
    static func saveData(_ url: String, _ imageData: Data) {
        // 儲存 圖片資料 和其 urlString
        imageDictionary[url] = imageData
    }
    
    static func retrievedData(_ url: String) -> Data? {
        // return 圖片資料 或 nil
        return imageDictionary[url]
    }
}
