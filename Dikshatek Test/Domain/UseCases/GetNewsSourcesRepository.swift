//
//  GetNewsSourcesRepository.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import Foundation
import RxSwift

protocol GetNewsSourcesUseCase {
    func execute(category: String?) -> Observable<NewsSourceResult>
}

final class DefaultGetNewsSourcesUseCase: GetNewsSourcesUseCase {
    let newsRepository: NewsRepository
    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func execute(category: String?) -> Observable<NewsSourceResult> {
        return newsRepository.getNewsSources(category: category)
    }
}

