//
//  OriginCell.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class OriginCell: UITableViewCell {

    static let ID = "OriginCell"

    // MARK: - Properties

    private let rectView = UIView()
    private let planetImageView = UIImageView()
    private let planetIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.backgroundColor = Colors.bgColor

        contentView.addSubview(rectView)
        rectView.backgroundColor = Colors.rectViewColor
        rectView.layer.cornerRadius = 16
        rectView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(planetImageView)
        planetImageView.layer.cornerRadius = 10
        planetImageView.backgroundColor = Colors.bgColor
        planetImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(descriptionLabel)
        descriptionLabel.font = UIFont(name: "Gilroy-Medium", size: 13)
        descriptionLabel.textColor = Colors.textGreenColor
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(planetIconImageView)
        planetIconImageView.image = UIImage(named: "Planet")
        planetIconImageView.clipsToBounds = true
        planetIconImageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            rectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            rectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            rectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            rectView.heightAnchor.constraint(equalToConstant: 74),

            planetImageView.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 8),
            planetImageView.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 8),
            planetImageView.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -8),
            planetImageView.widthAnchor.constraint(equalToConstant: 64),

            planetIconImageView.centerXAnchor.constraint(equalTo: planetImageView.centerXAnchor),
            planetIconImageView.centerYAnchor.constraint(equalTo: planetImageView.centerYAnchor),
            planetIconImageView.widthAnchor.constraint(equalToConstant: 24),
            planetIconImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -8),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -16),
        ])
    }

    // MARK: - Configure

    func configure(dataSource: LocationCellViewModelProtocol?) {
        if let dataSource{
            self.titleLabel.text = dataSource.name
            self.descriptionLabel.text = dataSource.type
        }
    }
}
