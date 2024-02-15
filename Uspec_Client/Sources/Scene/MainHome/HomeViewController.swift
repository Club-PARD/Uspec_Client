//
//  HomeViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}
