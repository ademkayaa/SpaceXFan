//
//  UpcomingLaunches.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import UIKit

final class UpcomingLaunches: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CardUIViewTableCell.self, forCellReuseIdentifier: CardUIViewTableCell.identifier)
        table.separatorStyle = .none
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        configureNavigationBar(with: "Upcoming Launches")
        loadTableViewCells()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func loadTableViewCells() {
        UpcomingLaunchesViewModel.shared.fetchItems(with: Constants.baseUrl + Constants.fetchByUpcoming) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension UpcomingLaunches: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UpcomingLaunchesViewModel.shared.getItemCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardUIViewTableCell.identifier, for: indexPath) as? CardUIViewTableCell else {
            return UITableViewCell()
        }

        cell.configure(with: UpcomingLaunchesViewModel.shared.getItem(at: indexPath.row), isFavoriteHidden: true)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsView()
        vc.rocket = UpcomingLaunchesViewModel.shared.getItem(at: indexPath.row)
        vc.isFavoriteHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

