//
//  DefaultNewsRepository.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation

import Foundation
import RxSwift

final class DefaultNewsRepository: NewsRepository {
    let remote: NewsRemoteDataSource
    
    init(remote: NewsRemoteDataSource) {
        self.remote = remote
    }
    
    func getNewsSources(category: String?) -> Observable<NewsSourceResult> {
        return remote.getNewsSources(category: category).map { source in
            return source.mapToDomain()
        }
    }
    
    func getNews() -> Observable<NewsResult> {
        return remote.getNews().map { newsResponseDTO in
            return newsResponseDTO.mapToDomain()
        }
    }
}
