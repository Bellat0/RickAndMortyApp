//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharactersList: UIViewController {

    //MARK: - enum for items and sizes collection

    enum Layout {
        static let itemsPerRow: CGFloat = 2
        static let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    //MARK: - private properties

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return vc
    }()

    private let titleLabel = UILabel()

    private let networkManager = NetworkManager()

    //MARK: - lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.bgColor

        setupViews()
        setupLayouts()
        detailsCollectionView()

        networkManager.fetchCharacterData()
    }

    //MARK: - private methods

    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = Colors.bgColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        titleLabel.text = " Characters"
        titleLabel.font = UIFont(name: "", size: 27)
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Gilroy-Bold", size: 28)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func setupLayouts() {
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func detailsCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            CharactersCell.self,
            forCellWithReuseIdentifier: CharactersCell.ID)
    }
}

//MARK: - Collection view data source

extension CharactersList: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharactersCell.ID,
            for: indexPath
        ) as? CharactersCell else { return UICollectionViewCell() }

        return cell
    }
}

//MARK: - Collection view DelegateFlowLayout

extension CharactersList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = 20 * (Layout.itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth/Layout.itemsPerRow

        return CGSize(width: widthPerItem + 2, height: 202)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return Layout.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 14
    }
}
