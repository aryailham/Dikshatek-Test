//
//  NewsCategoriesPresenter.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 22/02/24.
//

import Foundation
import UIKit

protocol NewsCategoriesPresenterInput {
    func goToNewsSourcesPage(origin: UIViewController, selectedIndex: Int)
}

protocol NewsCategoriesPresenterOutput {
    var categories: [NewsCategories] { get }
}

typealias NewsCategoriesPresenter = NewsCategoriesPresenterInput & NewsCategoriesPresenterOutput

final class DefaultNewsCategoriesPresenter: NewsCategoriesPresenter {  
    let router: NewsCategoriesRouter
    
    var categories: [NewsCategories] = [
        .all,
        .business,
        .entertainment,
        .general,
        .health,
        .science,
        .sports,
        .technology
    ]
    
    init(router: NewsCategoriesRouter) {
        self.router = router
    }

    func goToNewsSourcesPage(origin: UIViewController, selectedIndex: Int) {
        let selectedCategories = String(describing: categories[selectedIndex])
        saveSelectedSource(selectedCategories: selectedCategories)
        
        router.goToNewsSourcesPage(origin: origin)
    }
    
    private func saveSelectedSource(selectedCategories: String) {
        NewsFilterHelper.setCategory(category: selectedCategories)
    }
}
