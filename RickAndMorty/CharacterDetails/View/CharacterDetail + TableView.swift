//
//  CharacterDetail + TableView.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import UIKit

// MARK: - Table view data source

extension CharacterDetail: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.configure(dataSource: characterDetailsViewModel.characterCellViewModel)

        tableView.register(
            CharacterDetailHeaderSectionView.self,
            forHeaderFooterViewReuseIdentifier: CharacterDetailHeaderSectionView.ID)

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
            return episodeCellData?.count ?? 0
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

            cell.configure(dataSource: characterDetailsViewModel.characterCellViewModel)

            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: OriginCell.ID,
                for: indexPath
            ) as? OriginCell else { return UITableViewCell() }

            cell.configure(dataSource: originCellData)

            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EpisodesCell.ID,
                for: indexPath
            ) as? EpisodesCell else { return UITableViewCell() }

            let episode = episodeCellData?[indexPath.row]
            
            if let episode = episode {
                cell.configure(dataSource: episode)
            }

            return cell

        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerSectionView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: CharacterDetailHeaderSectionView.ID
        ) as? CharacterDetailHeaderSectionView else { return nil }

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
