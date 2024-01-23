//
//  InfoCell.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class InfoCell: UITableViewCell {

    static let ID = "InfoCell"

    // MARK: - Properties

    private let rectView = UIView()
    private let speciesTitleLabel = UILabel()
    private let typeTitleLabel = UILabel()
    private let genderTitleLabel = UILabel()

    private let speciesDescriptionLabel = UILabel()
    private let typeDescriptionLabel = UILabel()
    private let genderDescriptionLabel = UILabel()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    private func setupViews() {
        contentView.backgroundColor = Colors.bgColor

        contentView.addSubview(rectView)
        rectView.backgroundColor = Colors.rectViewColor
        rectView.layer.cornerRadius = 16
        rectView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(speciesTitleLabel)
        speciesTitleLabel.text = "Species:"
        speciesTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(typeTitleLabel)
        typeTitleLabel.text = "Type:"
        typeTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(genderTitleLabel)
        genderTitleLabel.text = "Gender:"
        genderTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(speciesDescriptionLabel)
        speciesDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesDescriptionLabel.numberOfLines = 0

        contentView.addSubview(typeDescriptionLabel)
        typeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        typeDescriptionLabel.numberOfLines = 0
        typeDescriptionLabel.textAlignment = .right

        contentView.addSubview(genderDescriptionLabel)
        genderDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        genderDescriptionLabel.numberOfLines = 0

        for setupText in [speciesTitleLabel, typeTitleLabel, genderTitleLabel] {
            setupText.textColor = Colors.textLightGrayColor
            setupText.font = UIFont(name: "Gilroy-Medium", size: 16)
        }

        for setupText in [speciesDescriptionLabel, typeDescriptionLabel, genderDescriptionLabel] {
            setupText.textColor = .white
            setupText.font = UIFont(name: "Gilroy-Medium", size: 16)
        }
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
        rectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        rectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
        rectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        rectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

        speciesTitleLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 16),
        speciesTitleLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 16),

        typeTitleLabel.topAnchor.constraint(equalTo: speciesTitleLabel.bottomAnchor, constant: 16),
        typeTitleLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 16),

        speciesDescriptionLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 16),
        speciesDescriptionLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -16),

        typeDescriptionLabel.topAnchor.constraint(equalTo: speciesTitleLabel.bottomAnchor, constant: 16),
        typeDescriptionLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -16),
        typeDescriptionLabel.leadingAnchor.constraint(equalTo: typeTitleLabel.trailingAnchor, constant: 50),

        genderTitleLabel.topAnchor.constraint(equalTo: typeDescriptionLabel.bottomAnchor, constant: 16),
        genderTitleLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 16),
        genderTitleLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -16),

        genderDescriptionLabel.topAnchor.constraint(equalTo: typeDescriptionLabel.bottomAnchor, constant: 16),
        genderDescriptionLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -16),
        genderDescriptionLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -16),
        ])
    }

    // MARK: - Configure

    func configure(dataSource: CharactersCellViewModelProtocol) {
        self.speciesDescriptionLabel.text = dataSource.species

        if dataSource.type == "" {
            self.typeDescriptionLabel.text = "None"
        } else {
            self.typeDescriptionLabel.text = dataSource.type
        }

        self.genderDescriptionLabel.text = dataSource.gender
    }
}
