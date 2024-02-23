//
//  NewsRemoteDataSource.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//
import Foundation
import Alamofire
import RxSwift

protocol NewsRemoteDataSource {
    func getNewsSources(category: String?) -> Observable<NewsSourceResultResponseDTO>
    func getNews(page: Int, source: String) -> Observable<NewsResponseDTO>
}

enum FetchError: String, Error {
    case APIKeyFailed = "API Key cannot be loaded"
    case URLFailed = "URL not found"
}

final class DefaultNewsRemoteDataSource: NewsRemoteDataSource {
    let GET_NEWS = "https://newsapi.org/v2/top-headlines"
    let GET_NEWS_CATEGORIES = "https://newsapi.org/v2/top-headlines/sources"
    
    func getNewsSources(category: String? = nil) -> Observable<NewsSourceResultResponseDTO> {
        guard let infoDict = Bundle.main.infoDictionary, let apiKey = infoDict["API_KEY"] as? String else {
            return Observable.error(FetchError.APIKeyFailed)
        }
        
        let urlString = self.GET_NEWS_CATEGORIES
        guard let url = URL(string: urlString) else {
            return Observable.error(FetchError.URLFailed)
        }
        
        var parameters: Parameters = [
            "apiKey": apiKey
        ]
        if let category = category {
            parameters["category"] = category
        }
        
        return Observable.create { observer in
            AF.request(url, method: .get, parameters: parameters)
                .responseDecodable(of: NewsSourceResultResponseDTO.self) { response in
                    switch response.result {
                    case .success(let success):
                        observer.onNext(success)
                        observer.onCompleted()
                    case .failure(let failure):
                        observer.onError(failure)
                    }
                }
            return Disposables.create()
        }
    }
    
    func getNews(page: Int, source: String) -> Observable<NewsResponseDTO> {
        guard let infoDict = Bundle.main.infoDictionary, let apiKey = infoDict["API_KEY"] as? String else {
            return Observable.error(FetchError.APIKeyFailed)
        }
        
        let urlString = String(format: self.GET_NEWS, apiKey)
        guard let url = URL(string: urlString) else {
            return Observable.error(FetchError.URLFailed)
        }
        
        var parameters: Parameters = [
            "apiKey": apiKey,
            "page": page,
            "sources": source
        ]

        return Observable.create { observer in
            AF.request(url, method: .get, parameters: parameters)
                .responseDecodable(of: NewsResponseDTO.self) { response in
                    switch response.result {
                    case .success(let success):
                        observer.onNext(success)
                        observer.onCompleted()
                    case .failure(let failure):
                        observer.onError(failure)
                    }
                }
            return Disposables.create()
        }
    }
}
