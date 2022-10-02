//
//  UpcomingLaunchesViewModel.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import Foundation

final class UpcomingLaunchesViewModel {

    private let rockets = [ "UpcomingLaunches 1",
                               "UpcomingLaunches 2",
                               "UpcomingLaunches 3",
                               "UpcomingLaunches 4",
                               "UpcomingLaunches 5",
                               "UpcomingLaunches 6" ]

    static let shared = UpcomingLaunchesViewModel()

    func getItem(at index: Int) -> String {
        return rockets[index]
    }

    func getItemCount() -> Int {
        return rockets.count
    }
}
