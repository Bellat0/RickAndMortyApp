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

    private let titleLabel = UILabel()

    private let networkManager = NetworkManager()

    private var characterModel: CharacterModel?

    //MARK: - Lyfe cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.bgColor

        setupViews()
        setupLayouts()
        detailsCollectionView()

        fetchData()
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

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func fetchData() {
        networkManager.fetchCharacterData() {[weak self] character in
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

        return 14
    }
}
