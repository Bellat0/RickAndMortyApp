//
//  Calculation.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 22.09.2023.
//

import UIKit

extension CharacterDetails {

    func heightForHeader() -> CGFloat {
        let characterNameData = characterData.name
        let characterStatusData = characterData.status

        let titleLabel = UILabel()
        let statusLabel = UILabel()

        titleLabel.text = characterNameData
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.numberOfLines = 0

        statusLabel.text = characterStatusData.rawValue
        statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        let constraintsLabel = CGSize(width: tableView.frame.width - 48, height: CGFloat.greatestFiniteMagnitude)

        let titleLabelSize = titleLabel.sizeThatFits(constraintsLabel)
        let statusLabelSize = statusLabel.sizeThatFits(constraintsLabel)

        let headerHeight = 16 + 148 + 24 + titleLabelSize.height + 8 + statusLabelSize.height + 16

        return headerHeight
    }

    func filteredEpisodes() -> [EpisodesResult] {
        let episode = episodeData?.results.filter({ episodesResult in
            episodesResult.characters.contains { character in
                character.hasSuffix("\(characterData.id)")
            }
        })

        return episode ?? []
    }

    func filteredLocation() -> LocationResult? {
        let episode = locationData?.results.first(where: { locationResult in
            locationResult.residents.contains { character in
                character.hasSuffix("\(characterData.id)")
            }
        })

        return episode
    }
}
