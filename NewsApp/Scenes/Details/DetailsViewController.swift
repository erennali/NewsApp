//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 23.04.2025.
//

import UIKit
import Kingfisher
import SnapKit

class DetailsViewController: UIViewController {

    // MARK: Properties
    
    private let viewModel: DetailsViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo")
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Inits
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
}

// MARK: Private Methods

private extension DetailsViewController {
    func configureView() {
        title = "News Detail"
        view.backgroundColor = .systemBackground
        addViews()
        configureLayout()
        articleImageView.kf.setImage(with: URL(string: viewModel.article.urlToImage ?? ""))
        configureLabels()
    }
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(articleImageView)
        view.addSubview(descriptionLabel)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        articleImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(articleImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configureLabels() {
        titleLabel.text = viewModel.article.title
        descriptionLabel.text = viewModel.article.description
    }
}
