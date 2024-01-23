//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharactersList: UIViewController {

    // MARK: - Properties

    private(set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return vc
    }()

    var cellDataSource = [CharactersCellViewModelProtocol]()

    // MARK: - ViewModel

    var charactersViewModel: CharactersListViewModelProtocol = CharactersListViewModel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupCollectionView()
        createTitleLabel()

        charactersViewModel.fetchCharacterData()
        bindCharactersCell()
    }

    // MARK: - Methods

    private func setupViews() {
        view.backgroundColor = Colors.bgColor
        collectionView.backgroundColor = Colors.bgColor

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createTitleLabel() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func bindCharactersCell() {
        charactersViewModel.characterData.bind { [weak self] characters in
            guard let self, let characters else { return }

            self.cellDataSource = characters

            self.reloadCollectionView()
        }
    }
}
