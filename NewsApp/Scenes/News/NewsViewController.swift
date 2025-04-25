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
}
