//
//  TableHeaderSectionView.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharacterDetailHeaderSectionView: UITableViewHeaderFooterView {

    static let ID = "TableHeaderSectionView"

    // MARK: - Properties

    private let titleLabel = UILabel()

    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViews() {
        contentView.backgroundColor = Colors.bgColor

        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
    }

    private func setupConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
    }

    // MARK: - Configure

    func configureTitle(title: String) {
        self.titleLabel.text = title
    }
}
