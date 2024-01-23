//
//  CharactersCell.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharactersCell: UICollectionViewCell {

    static let ID = "CharactersCell"

    // MARK: - Properties

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = Colors.rectViewColor
        
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        contentView.addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 140),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }

    // MARK: - Configure

    func configure(dataSource: CharactersCellViewModelProtocol) {
        self.imageView.image = nil

        self.activityIndicator.startAnimating()
        self.titleLabel.text = dataSource.name

        DispatchQueue.global().async {
            guard
                let imageUrl = URL(string: dataSource.image),
                let imageData = try? Data(contentsOf: imageUrl)
            else { return }

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}
