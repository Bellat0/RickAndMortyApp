//
//  InfoCell.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class InfoCell: UITableViewCell {

    static let ID = "InfoCell"

    //MARK: - Private properties

    private let rectView = UIView()
    private let speciesTitleLabel = UILabel()
    private let typeTitleLabel = UILabel()
    private let genderTitleLabel = UILabel()
    private let speciesDescriptionLabel = UILabel()
    private let typeDescriptionLabel = UILabel()
    private let genderDescriptionLabel = UILabel()

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
        speciesDescriptionLabel.text = "Human"
        speciesDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(typeDescriptionLabel)
        typeDescriptionLabel.text = "None"
        typeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(genderDescriptionLabel)
        genderDescriptionLabel.text = "Male"
        genderDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

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
        rectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        rectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        rectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        rectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

        speciesTitleLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 16).isActive = true
        speciesTitleLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 16).isActive = true

        typeTitleLabel.topAnchor.constraint(equalTo: speciesTitleLabel.bottomAnchor, constant: 16).isActive = true
        typeTitleLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 16).isActive = true

        genderTitleLabel.topAnchor.constraint(equalTo: typeTitleLabel.bottomAnchor, constant: 16).isActive = true
        genderTitleLabel.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 16).isActive = true
        genderTitleLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -16).isActive = true

        speciesDescriptionLabel.topAnchor.constraint(equalTo: rectView.topAnchor, constant: 16).isActive = true
        speciesDescriptionLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -16).isActive = true

        typeDescriptionLabel.topAnchor.constraint(equalTo: speciesTitleLabel.bottomAnchor, constant: 16).isActive = true
        typeDescriptionLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -16).isActive = true

        genderDescriptionLabel.topAnchor.constraint(equalTo: typeTitleLabel.bottomAnchor, constant: 16).isActive = true
        genderDescriptionLabel.trailingAnchor.constraint(equalTo: rectView.trailingAnchor, constant: -16).isActive = true
        genderDescriptionLabel.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -16).isActive = true
    }
}
