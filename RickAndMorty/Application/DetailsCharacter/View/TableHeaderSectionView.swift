//
//  TableHeaderSectionView.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class TableHeaderSectionView: UITableViewHeaderFooterView {

    static let ID = "TableHeaderSectionView"

    //MARK: - Private properties

    private let titleLabel = UILabel()

    //MARK: - Lyfe cycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = Colors.bgColor
        
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
    }

    private func setupConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
    }

    //MARK: - Configure methods

    func configureTitle(title: String) {
        self.titleLabel.text = title
    }
}
