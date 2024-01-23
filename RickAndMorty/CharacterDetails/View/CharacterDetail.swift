//
//  DetailsCharacter.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharacterDetail: UIViewController {

    // MARK: - Properties

    private(set) var tableView = UITableView()

    private(set) lazy var tableHeaderView: CharacterDetailHeaderView = {
        let height = CharacterDetailHeaderView.height(title: characterDetailsViewModel.characterCellViewModel.name, description: characterDetailsViewModel.characterCellViewModel.status)
        let headerFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)

        return CharacterDetailHeaderView(frame: headerFrame)
    }()

    var originCellData: LocationCellViewModelProtocol?
    var episodeCellData: [EpisodesCellViewModelProtocol]?

    // MARK: - ViewModel

    var characterDetailsViewModel: CharacterDetailsViewModelProtocol

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupTableView()

        characterDetailsViewModel.fetchLocationData()
        bindOriginCell()

        characterDetailsViewModel.fetchEpisodeData()
        bindEpisodesCell()
    }

    // MARK: - Init

    init(charactersCellViewModel: CharactersCellViewModelProtocol) {
        self.characterDetailsViewModel = CharacterDetailsViewModel(characterCellViewModel: charactersCellViewModel)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    private func setupViews() {
        tableView.backgroundColor = Colors.bgColor

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Bind Cell

    private func bindOriginCell() {
        characterDetailsViewModel.locationData.bind { [weak self] location in
            guard let self, let location else { return }

            self.originCellData = location

            self.reloadTableView()
        }
    }

    private func bindEpisodesCell() {
        characterDetailsViewModel.episodeData.bind { [weak self] episodes in
            guard let self, let episodes else { return }

            self.episodeCellData = episodes

            self.reloadTableView()
        }
    }
}
