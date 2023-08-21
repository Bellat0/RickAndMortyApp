//
//  TableHeaderView.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class TableHeaderView: UIView {

    //MARK: - Private properties

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()

    //MARK: - Lyfe cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Colors.bgColor

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods

    private func setupViews() {
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
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 148).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 148).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }

    //MARK: - Configure methods

    func configureCell(character: CharacterResult) {
        self.activityIndicator.startAnimating()
        self.imageView.image = nil
        self.titleLabel.text = character.name
        self.statusLabel.text = character.status.rawValue

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
