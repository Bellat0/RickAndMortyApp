//
//  TableHeaderView.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharacterDetailHeaderView: UIView {

    // MARK: - Properties

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()

    // MARK: - Init

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
        backgroundColor = Colors.bgColor

        addSubview(imageView)
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Gilroy-Bold", size: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(statusLabel)
        statusLabel.textColor = Colors.textGreenColor
        statusLabel.font = UIFont(name: "Gilroy-Medium", size: 16)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 148),
            imageView.heightAnchor.constraint(equalToConstant: 148),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }

    static func height(title: String, description: String) -> CGFloat {
        let characterNameData = title
        let characterStatusData = description

        let titleLabel = UILabel()
        let statusLabel = UILabel()

        titleLabel.text = characterNameData
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.numberOfLines = 0

        statusLabel.text = characterStatusData
        statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        let constraintsLabel = CGSize(width: UIScreen.main.bounds.width - 48, height: CGFloat.greatestFiniteMagnitude)

        let titleLabelSize = titleLabel.sizeThatFits(constraintsLabel)
        let statusLabelSize = statusLabel.sizeThatFits(constraintsLabel)

        let headerHeight = 16 + 148 + 24 + titleLabelSize.height + 8 + statusLabelSize.height + 16

        return headerHeight
    }

    // MARK: - Configure

    func configure(dataSource: CharactersCellViewModelProtocol) {
        self.activityIndicator.startAnimating()
        self.imageView.image = nil
        self.titleLabel.text = dataSource.name
        self.statusLabel.text = dataSource.status

        DispatchQueue.global().async {
            guard
                let url = URL(string: dataSource.image),
                let data = try? Data(contentsOf: url)
            else { return }

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: data)
            }
        }
    }
}
