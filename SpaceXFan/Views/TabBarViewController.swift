//
//  TabBarViewController.swift
//  SpaceXFan
//
//  Created by Adem Kaya (employee ID: a84252243) on 2022/10/1.
//


import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: AllSpaceXRockets())
        let vc2 = UINavigationController(rootViewController: FavoriteRockets())
        let vc3 = UINavigationController(rootViewController: UpcomingLaunches())

        vc1.tabBarItem.image = UIImage(systemName: "paperplane")
        vc2.tabBarItem.image = UIImage(systemName: "heart.circle.fill")
        vc3.tabBarItem.image = UIImage(systemName: "scanner.fill")

        vc1.title = "All SpaceX Rockets"
        vc2.title = "Favorite Rockets"
        vc3.title = "Upcoming Launches"

        tabBar.tintColor = .systemBlue

        let appearance = tabBar.standardAppearance
        appearance.configureWithDefaultBackground()
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBar.standardAppearance = appearance
        }

        setViewControllers([vc1, vc2, vc3], animated: true)
    }
}

