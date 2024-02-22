//
//  NewsFilterHelper.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import Foundation

final class NewsFilterHelper {
    static func setSource(source: String) {
        UserDefaults.standard.setValue(source, forKey: "selectedNewsSource")
    }
    
    static func getSource() -> String? {
        let savedSource = UserDefaults.standard.string(forKey: "selectedNewsSource")
        
        return savedSource
    }
    
    static func setCategory(category: String) {
        UserDefaults.standard.setValue(category, forKey: "selectedCategories")
    }
    
    static func getCategory() -> String? {
        let savedCategory = UserDefaults.standard.string(forKey: "selectedCategories")
        
        return savedCategory
    }

}
