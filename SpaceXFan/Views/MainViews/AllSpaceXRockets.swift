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

    lazy var userLoginButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Log In", for: .normal)
        view.setTitle("Log Out", for: .selected)
        view.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
        view.titleLabel?.textColor = .label
        view.titleLabel?.numberOfLines = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self


        configureNavigationBar(with: "All SpaceX Rockets")
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userLoginButton)
        loadTableViewCells()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshFavorites),
                                               name: Notification.Name("UserLoggedIn"),
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshSignInButton),
                                               name: Notification.Name("refreshSignInButton"),
                                               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {

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

    @objc func tapLogin(_ sender: UIButton) {
        sender.isSelected.toggle()

        if sender.isSelected {
            navigationController?.pushViewController(SignInViewController(), animated: true)
        } else {
            FBAuth.shared.signOut() { result in
                switch(result) {
                case.success(_):
                    print("signOut success")
                    NotificationCenter.default.post(name: Notification.Name("UserLoggedIn"), object: nil)
                    NotificationCenter.default.post(name: Notification.Name("FavoriteTab"), object: nil)
                case.failure(_):
                    print("signOut fail")
                }
            }
        }
    }

    @objc func refreshFavorites() {
        tableView.reloadData()
        print("reload")
    }

    @objc func refreshSignInButton() {
        if !userLoginButton.isSelected {
            userLoginButton.isSelected.toggle()
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
        cell.delegate = self

        let item = AllSpaceXRocketsViewModel.shared.getItem(at: indexPath.row)

        if let count = FBFireStore.shared.favorite?.filter({ $0 == item.name }).count {
            let isFavorite = count >= 1 ? true : false

            cell.favorite.isSelected = isFavorite
        } else {
            cell.favorite.isSelected = false
        }

        cell.configure(with: item, isFavoriteHidden: false)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsView()

        let item = AllSpaceXRocketsViewModel.shared.getItem(at: indexPath.row)
        vc.rocket = item

        if let count = FBFireStore.shared.favorite?.filter({ $0 == item.name }).count {
            let isFavorite = count >= 1 ? true : false
            vc.isFavorite = isFavorite
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}


extension AllSpaceXRockets: CardUIViewDelegate {
    func tapHeart(_ sender: UIButton, data: String) {

        sender.isSelected.toggle()

        if sender.isSelected {
            if !FBAuth.shared.isSignedIn {
                navigationController?.pushViewController(SignInViewController(), animated: true)
            } else {
                FBFireStore.shared.setData(with: data, for: FBAuth.shared.currentUserId)
            }

        } else {
            FBFireStore.shared.deleteData(with: data, for: FBAuth.shared.currentUserId)
        }
    }
}
