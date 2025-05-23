//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 13.03.2025.
//

import Foundation


enum Mode: Equatable {
    case top
    case search(String)
}
final class NewsViewModel {
    
    //MARK: Properties
    
    private let newsService: NewsServiceProtocol
    weak var delegate: NewsViewControllerProtocol?
    
    private var mode: Mode = .top
    
    private var isLoading: Bool = false
    private var page = 1
            
    
    private let devounceInterval: TimeInterval = 1
    private var debounceWorkItem: DispatchWorkItem?
        
    
    private(set) var articles: [Article] = []
    
    init(
        newsService: NewsServiceProtocol = NewsService()
    ) {
        self.newsService = newsService
    }
    
    deinit { debounceWorkItem?.cancel() }
}

extension NewsViewModel {
    func fetchTopNews() {
        newsService.fetchTopNews (
            country: "us",
            page: 1,
            pageSize: 10) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    self.articles = success.articles
                    self.delegate?.reloadData()
                case .failure(let failure):
                    print("Failed to fetch news: \(failure)")
                }
            }
    }
    func fetch(reset: Bool) {
        guard !isLoading else { return }
        isLoading = true
        if reset {
            page = 1
        }
        
        let completion: (Result<NewsModel, NetworkError>) -> Void = { [weak self] result in
            guard let self = self else { return }
            isLoading = false
            switch result {
            case .success(let response):
                if reset {
                    articles = response.articles
                }else {
                    articles += response.articles
                    // yeni çektiğimiz verileri mevcut verilere ekliyoruz
                }
                
                self.delegate?.reloadData()
            case .failure(let error):
                print("Failed to fetch news: \(error)")
            }
        }
        switch mode {
        case .top:
            newsService.fetchTopNews(
                country: "us",
                page: page,
                pageSize: 20,
                completion: completion)
        case .search(let query):
            newsService.searchNews(
                searchString: query,
                page: page,
                pageSize: 20,
                completion: completion)
        }
    }
    
    func search(term: String) {
        let trimmed = term.trimmingCharacters(in: .whitespacesAndNewlines)
        debounceWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.mode = trimmed.isEmpty ? .top : .search(trimmed)
            self.fetch(reset: true)
        }
        debounceWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + devounceInterval, execute: workItem)
        
     }
    
    func loadMore() {
        page += 1
        fetch(reset: false)
        
    }
}
