//
//  NewsSource.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import Foundation

struct NewsSourceResult: Codable {
    let status: String
    let sources: [NewsSource]
}

struct NewsSource: Codable {
    let id, name, description: String
    let url: String
    let category: String
    let language, country: String
}
