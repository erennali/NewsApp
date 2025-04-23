//
//  NewsCell.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 23.04.2025.
//

import UIKit
import SnapKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    // MARK: Properties

    static let identifier = "NewsCell"
    
    private var article: Article?
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(systemName: "photo.artframe")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemBlue
        return label
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        /* contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16)
         */
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public Methods

extension NewsCell {
    func configure(with article: Article) {
        self.article = article
        titleLabel.text = article.title
        authorLabel.text = article.author
        dateLabel.text = article.publishedAt
        newsImageView.kf.setImage(with: URL(string: article.urlToImage ?? ""))
        
    }
}

// MARK: Private Methods
private extension NewsCell {
    func configureView() {
        addViews()
        configureLayout()
    }
    
    func addViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        newsImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(140 )
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(newsImageView.snp.trailing)
                .offset(12)
            $0.trailing.equalToSuperview().offset(-16)
        }
        authorLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(newsImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-16)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(newsImageView.snp.trailing).offset(12)
            $0.top.equalTo(newsImageView.snp.bottom).offset(12)
            $0.height.equalTo(24)
        }
        
    }
}

#Preview {
    NewsViewController()
}
