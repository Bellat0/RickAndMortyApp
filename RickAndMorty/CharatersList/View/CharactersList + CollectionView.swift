//
//  CharactersList + TableView.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import UIKit

// MARK: - Item size

enum Layout {
    static let itemsPerRow: CGFloat = 2
    static let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
}

// MARK: - Collection view data source

extension CharactersList: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            CharactersCell.self,
            forCellWithReuseIdentifier: CharactersCell.ID)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharactersCell.ID,
            for: indexPath
        ) as? CharactersCell else { return UICollectionViewCell() }

        cell.configure(dataSource: cellDataSource[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellDataSource = cellDataSource[indexPath.row]
        let characterDetailVC = CharacterDetail(charactersCellViewModel: cellDataSource)

        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}

// MARK: - Collection view DelegateFlowLayout

extension CharactersList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // MARK: Width
        let paddingWidth = 20 * (Layout.itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemWidth = availableWidth/Layout.itemsPerRow

        // MARK: Height
        let characterName = cellDataSource[indexPath.row]

        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = characterName.name

        let constraintTitleSize = CGSize(width: itemWidth - 32, height: CGFloat.greatestFiniteMagnitude)
        let titleSize = titleLabel.sizeThatFits(constraintTitleSize)

        let itemHeight: CGFloat = 8 + 140 + 16 + titleSize.height + 16

        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return Layout.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return Layout.insets.bottom - 4
    }
}
