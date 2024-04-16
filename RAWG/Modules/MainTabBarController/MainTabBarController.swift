//
//  MainTabBarController.swift
//  RAWG
//
//  Created by Артур on 25.02.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barStyle = .black
        self.tabBar.isTranslucent = true
        
        setupTabs()
        
    }
    
    private func setupTabs() {
        let homeVC = self.createNavigationChain(title: "Home", image: UIImage(systemName: "house") ?? UIImage(), vc: HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil))
        let searchVC = self.createNavigationChain(title: "Search", image: UIImage(systemName: "magnifyingglass") ?? UIImage(), vc: SearchViewController(nibName: String(describing: SearchViewController.self), bundle: nil))
        
        self.setViewControllers([homeVC, searchVC], animated: true)
    }
    
    private func createNavigationChain(title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        navigationController.navigationBar.barStyle = .black
        navigationController.hidesBarsOnSwipe = true
        
        
        return navigationController
    }
}
