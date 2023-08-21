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

    private var characterResult: CharacterResult

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
    }

    //MARK: - Private methods

    private func setupViews() {
        view.addSubview(tableView)
        tableView.backgroundColor = Colors.bgColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
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
            InfoCell.self,
            forCellReuseIdentifier: InfoCell.ID)
    }
}

//MARK: - Table view

extension CharacterDetails: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: InfoCell.ID,
            for: indexPath
        ) as? InfoCell else { return UITableViewCell() }

        return cell
    }
}
