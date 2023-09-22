//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharactersList: UIViewController {

    //MARK: - Enum for items and sizes collection

    enum Layout {
        static let itemsPerRow: CGFloat = 2
        static let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    //MARK: - Private properties

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return vc
    }()

    //MARK: - Внешние зависимости

    var dataFetcher = DataFetcherService()
    var characterModel: CharacterModel?

    //MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.bgColor
        collectionView.backgroundColor = Colors.bgColor

        setupViews()
        setupLayouts()
        setupCollectionView()
        createTitleLabel()

        fetchData()
    }

    //MARK: - private methods

    private func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.text = " Characters"

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLayouts() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            CharactersCell.self,
            forCellWithReuseIdentifier: CharactersCell.ID)
    }

    //MARK: - Networking

    private func fetchData() {
        dataFetcher.fetchUserData { [weak self] character in
            self?.characterModel = character
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

//MARK: - Collection view data source

extension CharactersList: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterModel?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharactersCell.ID,
            for: indexPath
        ) as? CharactersCell else { return UICollectionViewCell() }

        let character = characterModel?.results[indexPath.row]
        cell.configureCell(character: character!)
        
        return cell
    }

    //MARK: - Collection view didSelectItemAt

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterResult = characterModel?.results[indexPath.row]
        let detailsVC = CharacterDetails(characterResult: characterResult!)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

//MARK: - Collection view DelegateFlowLayout

extension CharactersList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = 20 * (Layout.itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth/Layout.itemsPerRow

        let character = characterModel?.results[indexPath.row]

        let constraintTitleSize = CGSize(width: (widthPerItem + 2) - 16, height: CGFloat.greatestFiniteMagnitude)

        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Gilroy-SemiBold", size: 17)
        titleLabel.text = character?.name
        titleLabel.numberOfLines = 0

        let labelSize = titleLabel.sizeThatFits(constraintTitleSize)
        let itemHeight: CGFloat = 8 + 140 + 16 + labelSize.height + 16

        return CGSize(width: widthPerItem + 2, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return Layout.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return Layout.insets.bottom - 4
    }
}
