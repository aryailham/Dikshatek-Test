//
//  News+Codable.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation

struct NewsResponseDTO: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleResponseDTO]
    
    func mapToDomain() -> NewsResult {
        let articlesDomain = self.articles.map { article in
            return article.mapToDomain()
        }
        
        return NewsResult(status: self.status,
                          totalResults: self.totalResults,
                          articles: articlesDomain)
    }
}

// MARK: - Article
struct ArticleResponseDTO: Codable {
    let source: SourceResponseDTO
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    func mapToDomain() -> Article {
        return Article(source: self.source.mapToDomain(),
                       author: self.author,
                       title: self.title,
                       description: self.description,
                       url: self.url,
                       urlToImage: self.urlToImage,
                       publishedAt: self.publishedAt,
                       content: self.content)
    }
}

// MARK: - Source
struct SourceResponseDTO: Codable {
    let id: String?
    let name: String
    
    func mapToDomain() -> Source {
        return Source(id: self.id, name: self.name)
    }
}
