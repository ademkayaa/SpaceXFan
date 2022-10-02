//
//  DetailView.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import UIKit

final class DetailsView: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(DetailsIdentityUITableViewCell.self, forCellReuseIdentifier: DetailsIdentityUITableViewCell.identifier)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 600
        return table
    }()

    var rocket: Rocket?
    private var headerView: DetailHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        configureNavigationBar(with: rocket?.name ?? "Details")
        configureHeaderUIView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func configureHeaderUIView() {
        headerView = DetailHeaderView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: view.bounds.width,
                                                height: 300))
        headerView?.configure(with: rocket?.imagesUrl ?? [])
        tableView.tableHeaderView = headerView
    }
}

extension DetailsView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsIdentityUITableViewCell.identifier, for: indexPath) as? DetailsIdentityUITableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: rocket!)

        cell.selectionStyle = .none
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = CountriesViewController()
//        vc.region = ContinentsViewModel.shared.getContinent(at: indexPath.row)
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

