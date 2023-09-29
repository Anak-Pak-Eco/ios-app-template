//
//  FeaturesA.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 29/09/23.
//

import Foundation
import UIKit

class FeaturesAViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onMoveToBClicked(_ sender: UIButton) {
        navigateToFeaturesB()
    }
}

extension FeaturesAViewController {
    func navigateToFeaturesB() {
        let vc = FeaturesBViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.title = "Test"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
