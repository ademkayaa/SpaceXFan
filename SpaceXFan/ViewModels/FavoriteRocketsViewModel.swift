//
//  FavoriteRocketsViewModel.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import Foundation
import Alamofire
import SwiftyJSON

final class FavoriteRocketsViewModel {

    private var items: [Rocket] = []
    private var favorite: [Rocket] = []
    static let shared = FavoriteRocketsViewModel()

    func fetchItems(with urlStr: String, completion: @escaping () -> Void) {

        guard let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        guard let url = URL(string: urlStr) else {
            return
        }

        AF.request(url, method: .get).response { [weak self] payload in

            guard let self = self else {
                return
            }

            switch payload.result {
            case .success(let value):

                let json = JSON(value as Any).arrayValue

                self.unload()
                self.load(with: json)

                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func load(with json: [JSON]) {
        for el in json {
            items.append(Rocket(with: el))
        }
    }

    private func unload() {
        items = []
    }

    func prepareFavorite() {
        favorite = []
        for item in items {
            if let count = FBFireStore.shared.favorite?.filter({ $0 == item.name }).count {
                if count >= 1 {
                    favorite.append(item)
                }
            }
        }
    }

    func getItem(at index: Int) -> Rocket {

        return favorite[index]
    }

    func getItemCount() -> Int {
        return favorite.count
    }
}
