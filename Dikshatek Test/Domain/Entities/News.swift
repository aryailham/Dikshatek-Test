//
//  News.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation

struct NewsResult {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source {
    let id: String?
    let name: String
}

