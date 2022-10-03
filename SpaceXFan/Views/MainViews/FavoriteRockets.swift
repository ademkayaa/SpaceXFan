//
//  FavoriteRockets.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import UIKit

final class FavoriteRockets: UIViewController {

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


        configureNavigationBar(with: "Favorite Rockets")
        loadTableViewCells()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshFavorites),
                                               name: Notification.Name("FavoriteTab"),
                                               object: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func checkIfsignIn() {

        if !FBAuth.shared.isSignedIn {
            navigationController?.pushViewController(SignInViewController(), animated: true)
        }
    }

    private func loadTableViewCells() {
        FavoriteRocketsViewModel.shared.fetchItems(with: Constants.baseUrl + Constants.fetchByRockets) { [weak self] in
            DispatchQueue.main.async {
                FavoriteRocketsViewModel.shared.prepareFavorite()
                self?.tableView.reloadData()
            }
        }
    }

    @objc func refreshFavorites() {
        FavoriteRocketsViewModel.shared.prepareFavorite()
        tableView.reloadData()
        print("reload")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        checkIfsignIn()

        FavoriteRocketsViewModel.shared.prepareFavorite()
        tableView.reloadData()
    }
}

extension FavoriteRockets: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteRocketsViewModel.shared.getItemCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardUIViewTableCell.identifier, for: indexPath) as? CardUIViewTableCell else {
            return UITableViewCell()
        }
        cell.delegate = self

        let item = FavoriteRocketsViewModel.shared.getItem(at: indexPath.row)
        cell.favorite.isSelected = true

        cell.configure(with: item, isFavoriteHidden: false)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = DetailsView()

        let item = FavoriteRocketsViewModel.shared.getItem(at: indexPath.row)
        vc.rocket = item

        if let count = FBFireStore.shared.favorite?.filter({ $0 == item.name }).count {
            let isFavorite = count >= 1 ? true : false
            vc.isFavorite = isFavorite
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}


extension FavoriteRockets: CardUIViewDelegate {
    func tapHeart(_ sender: UIButton, data: String) {

        sender.isSelected.toggle()

        if sender.isSelected {
            if !FBAuth.shared.isSignedIn {
                navigationController?.pushViewController(SignInViewController(), animated: true)

                if FBAuth.shared.isSignedIn {
                    sender.isSelected.toggle()
                }
            } else {
                FBFireStore.shared.setData(with: data, for: FBAuth.shared.currentUserId)
            }

        } else {
            FBFireStore.shared.deleteData(with: data, for: FBAuth.shared.currentUserId)
        }
    }
}


