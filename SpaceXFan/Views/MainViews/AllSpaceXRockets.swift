//
//  AllSpaceXRockets.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//
import UIKit

final class AllSpaceXRockets: UIViewController {

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

        configureNavigationBar(with: "All SpaceX Rockets")
        loadTableViewCells()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func loadTableViewCells() {
        AllSpaceXRocketsViewModel.shared.fetchItems(with: Constants.baseUrl + Constants.fetchByRockets) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension AllSpaceXRockets: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllSpaceXRocketsViewModel.shared.getItemCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardUIViewTableCell.identifier, for: indexPath) as? CardUIViewTableCell else {
            return UITableViewCell()
        }

        cell.configure(with: AllSpaceXRocketsViewModel.shared.getItem(at: indexPath.row), isFavoriteHidden: false)
//        cell.textLabel?.text = AllSpaceXRocketsViewModel.shared.getItem(at: indexPath.row).name
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsView()

        vc.rocket = AllSpaceXRocketsViewModel.shared.getItem(at: indexPath.row)
//        vc.region = ContinentsViewModel.shared.getContinent(at: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(Constants.cellHight)
//    }
}
