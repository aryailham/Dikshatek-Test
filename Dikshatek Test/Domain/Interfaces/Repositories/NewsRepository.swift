//
//  NewsRepository.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation
import RxSwift

protocol NewsRepository {
    func getNewsSources(category: String?) -> Observable<NewsSourceResult>
    func getNews() -> Observable<NewsResult>
}
