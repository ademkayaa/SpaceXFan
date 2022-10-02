//
//  FavoriteRocketsViewModel.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import Foundation

final class FavoriteRocketsViewModel {

    private let rockets = [ "FavoriteRockets 1",
                               "FavoriteRockets 2",
                               "FavoriteRockets 3",
                               "FavoriteRockets 4",
                               "FavoriteRockets 5",
                               "FavoriteRockets 6" ]

    static let shared = FavoriteRocketsViewModel()

    func getItem(at index: Int) -> String {
        return rockets[index]
    }

    func getItemCount() -> Int {
        return rockets.count
    }
}
