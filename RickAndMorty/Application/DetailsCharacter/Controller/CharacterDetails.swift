//
//  DetailsCharacter.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharacterDetails: UIViewController {

    //MARK: - Private properties

    private let tableView = UITableView()
    private let tableHeaderView = TableHeaderView(
        frame: CGRect(x: 0, y: 0, width: 161,
                      height: 16 + 148 + 24 + 22 + 8 + 24 + 16))

    private let networkManager = NetworkManager()

    private var characterResult: CharacterResult
    private var locationModel: LocationModel?
    private var episodesModel: EpisodeModel?

    //MARK: - Lyfe cycle

    init(characterResult: CharacterResult) {
        self.characterResult = characterResult

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        detailsTableView()
        fetchData()
    }

    //MARK: - Private methods

    private func setupViews() {
        view.addSubview(tableView)
        tableView.backgroundColor = Colors.bgColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
    }

    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func detailsTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.configureCell(character: characterResult)

        tableView.register(
            TableHeaderSectionView.self,
            forHeaderFooterViewReuseIdentifier: TableHeaderSectionView.ID)

        tableView.register(
            InfoCell.self,
            forCellReuseIdentifier: InfoCell.ID)

        tableView.register(
            OriginCell.self,
            forCellReuseIdentifier: OriginCell.ID)

        tableView.register(
            EpisodesCell.self,
            forCellReuseIdentifier: EpisodesCell.ID)
    }

    func filteredEpisodes() -> [EpisodesResult] {
        let episodes = episodesModel?.results.filter({ episode in
            episode.characters.contains { characterString in
                characterString.hasSuffix("\(characterResult.id)")
            }
        })

        return episodes ?? []
    }


    private func fetchData() {
        networkManager.fetchLocationData { [weak self] locationData in
            self?.locationModel = locationData
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        networkManager.fetchEpisodeData { [weak self] episodeData in
            self?.episodesModel = episodeData
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - Table view

extension CharacterDetails: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return filteredEpisodes().count
        default:
            break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: InfoCell.ID,
                for: indexPath
            ) as? InfoCell else { return UITableViewCell() }

            cell.configureCell(character: characterResult)
            return cell

        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OriginCell.ID,
                for: indexPath
            ) as? OriginCell else { return UITableViewCell() }

            let location = locationModel?.results.first(where: { locationResult in
                locationResult.residents.contains { resident in
                    resident.hasSuffix("\(characterResult.id)")
                }
            })

            if let location = location {
                cell.configureCell(location: location)
            } else {
                print("")
            } 
            return cell
        } else if indexPath.section == 2 {

            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EpisodesCell.ID,
                for: indexPath
            ) as? EpisodesCell else { return UITableViewCell() }


            let newEpisodes = filteredEpisodes()

            let episode = newEpisodes[indexPath.row]

            cell.configureCell(episodes: episode)


            return cell
        }

        return UITableViewCell()
    }

    //MARK: - Table view header section

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerSectionView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TableHeaderSectionView.ID
        ) as? TableHeaderSectionView else { return nil }

        switch section {
        case 0:
            headerSectionView.configureTitle(title: "Info")
        case 1:
            headerSectionView.configureTitle(title: "Origin")
        case 2:
            headerSectionView.configureTitle(title: "Episodes")
        default:
            headerSectionView.configureTitle(title: "New section")
        }
        return headerSectionView
    }
}
