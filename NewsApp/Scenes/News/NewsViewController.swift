//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 7.03.2025.
//

import UIKit
import SnapKit

protocol NewsViewControllerProtocol: AnyObject {
  func reloadData()
}

final class NewsViewController: UIViewController {

    
    //MARK: Properties
    private let viewModel: NewsViewModel
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search News"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.rowHeight = 180
        return tableView
    }()
    
    init(viewModel: NewsViewModel = NewsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureView()
        viewModel.fetchTopNews()
        
    }
    
}

private extension NewsViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

extension NewsViewController: NewsViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.configure(with: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = viewModel.articles[indexPath.row]
        let detailsVM = DetailsViewModel(article: selectedArticle)
        let detailsViewController = DetailsViewController(viewModel: detailsVM)
        navigationController?.pushViewController(detailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // eğer ekranın en altında isek son haberde isek
        if indexPath.row == viewModel.articles.count - 1 {
            viewModel.loadMore()
        }
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.search(term: "")
        } else if searchText.count >= 3 {
            viewModel.search(term: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(term: "")
        
    }
}
