//
//  OriginCell.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class OriginCell: UITableViewCell {

    static let ID = "OriginCell"

    //MARK: - Private properties

    private let rectView = UIView()
    private let planetImageView = UIImageView()
    private let planetIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()

    //MARK: - Lyfe cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = Colors.bgColor

        setupViews()
        setupConstraint()
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
        rectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        rectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        rectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        rectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

        planetImageView.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 8).isActive = true
        planetImageView.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 8).isActive = true
        planetImageView.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -8).isActive = true
        planetImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true

        planetIconImageView.centerXAnchor.constraint(equalTo: planetImageView.centerXAnchor).isActive = true
        planetIconImageView.centerYAnchor.constraint(equalTo: planetImageView.centerYAnchor).isActive = true
        planetIconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        planetIconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        titleLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -8).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -16).isActive = true
    }

    //MARK: - Configure methods

    func configureCell(location: LocationResult) {
        self.titleLabel.text = location.name
        self.descriptionLabel.text = location.type
    }
}
