//
//  EpisodesCell.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class EpisodesCell: UITableViewCell {

    static let ID = "EpisodesCell"

    //MARK: - Private properties

    private let rectView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()

    //MARK: - Lyfe cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = Colors.bgColor

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
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
        rectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        rectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        rectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        rectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

        titleLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 15.25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -15.25).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 15.25).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -14).isActive = true

        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -15.68).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -14).isActive = true
    }

    //MARK: - Configure methods

    func configureCell(episodes: EpisodesResult) {
        self.titleLabel.text = episodes.name
        self.descriptionLabel.text = episodes.episode
        self.dateLabel.text = episodes.created
    }
}
