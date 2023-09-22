//
//  DetailsCharacter.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

class CharacterDetails: UIViewController {

    //MARK: - Private properties

    let tableView = UITableView()

    private lazy var tableHeaderView: TableHeaderView = {
        let headerHeight = heightForHeader()
        let headerFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightForHeader())

        return TableHeaderView(frame: headerFrame)
    }()

    //MARK: - Внешние зависимости

    var dataFetcher = DataFetcherService()

    var characterData: CharacterResult
    var locationData: LocationModel?
    var episodeData: EpisodeModel?
    

    //MARK: - View lifecycle

    init(characterResult: CharacterResult) {
        self.characterData = characterResult

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = Colors.bgColor

        setupViews()
        setupConstraints()
        setupTableView()
        createBackButton()

        fetchData()
    }

    //MARK: - Private methods

    private func createBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .done,
            target: self,
            action: #selector(backButtonTapped))
        backButton.tintColor = .white

        navigationItem.leftBarButtonItem = backButton

        let swipeBackGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(backButtonTapped))
        view.addGestureRecognizer(swipeBackGesture)
    }

    private func setupViews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.configureCell(character: characterData)

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

    //MARK: - Action methods

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    //MARK: - Network methods

    private func fetchData() {
        dataFetcher.fetchLocationData { [weak self] locationInfo in
            self?.locationData = locationInfo
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        dataFetcher.fetchEpisodeData { [weak self] episodeData in
            self?.episodeData = episodeData
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

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: InfoCell.ID,
                for: indexPath
            ) as? InfoCell else { return UITableViewCell() }

            cell.configureCell(character: characterData)

            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OriginCell.ID,
                for: indexPath
            ) as? OriginCell else { return UITableViewCell() }

            let location = filteredLocation()

            if let location = location {
                cell.configureCell(location: location)
            } else {
                print("")
            }

            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EpisodesCell.ID,
                for: indexPath
            ) as? EpisodesCell else { return UITableViewCell() }


            let newEpisodes = filteredEpisodes()
            let episode = newEpisodes[indexPath.row]

            cell.configureCell(episodes: episode)

            return cell

        default: break
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
