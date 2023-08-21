//
//  CharactersCell.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharactersCell: UICollectionViewCell {

    static let ID = "CharactersCell"

    //MARK: - Private properties

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()

    //MARK: - Lyfe cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = Colors.rectViewColor

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "12312312 321321312"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        contentView.addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true

        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }

    //MARK: - Configure methods

    func configureCell(character: CharacterResult) {
        self.activityIndicator.startAnimating()
        self.imageView.image = nil
        self.titleLabel.text = character.name

        DispatchQueue.global().async {
            guard
                let url = URL(string: character.image),
                let data = try? Data(contentsOf: url)
            else { return }

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: data)
            }
        }
    }
}
