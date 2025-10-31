//
//  HomeViewController.swift
//  RegistrationApp
//
//  Created by Apurva Jalgaonkar on 31/10/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetupUI()
    }

    private func initialSetupUI() {
        titleLabel.text = "WELCOME!!!"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
    }
}
