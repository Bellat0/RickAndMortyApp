//
//  EpisodesCell.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class EpisodesCell: UITableViewCell {

    static let ID = "EpisodesCell"

    // MARK: - Properties

    private let rectView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
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

        contentView.addSubview(titleLabel)
        titleLabel.text = "Pilot"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(descriptionLabel)
        descriptionLabel.text = "Episode: 1, Season: 1"
        descriptionLabel.font = UIFont(name: "Gilroy-Medium", size: 13)
        descriptionLabel.textColor = Colors.textGreenColor
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(dateLabel)
        dateLabel.text = "December 9, 2013"
        dateLabel.font = UIFont(name: "Gilroy-Medium", size: 12)
        dateLabel.textColor = Colors.textGrayColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            rectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            rectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            titleLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 15.25),
            titleLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -15.25),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 15.25),
            descriptionLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -14),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -15.68),
            dateLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -14),
        ])
    }

    // MARK: - Configure

    func configure(dataSource: EpisodesCellViewModelProtocol?) {
        if let dataSource {
            titleLabel.text = dataSource.name
            descriptionLabel.text = dataSource.episode
            dateLabel.text = dataSource.airDate
        } else {
            print("Some error!!!!111")
        }
    }
}
