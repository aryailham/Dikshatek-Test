//
//  NewsSources+Codable.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation

struct NewsSourceResultResponseDTO: Codable {
    let status: String
    let sources: [NewsSourceResponseDTO]
    
    func mapToDomain() -> NewsSourceResult {
        let mappedSources = self.sources.map { source in
            return source.mapToDomain()
        }
        
        return NewsSourceResult(status: self.status, sources: mappedSources)
    }
}

struct NewsSourceResponseDTO: Codable {
    let id, name, description: String
    let url: String
    let category: String
    let language, country: String
    
    func mapToDomain() -> NewsSource {
        return NewsSource(id: self.id,
                          name: self.name, 
                          description: self.description,
                          url: self.url,
                          category: self.category,
                          language: self.language,
                          country: self.country)
    }
}
