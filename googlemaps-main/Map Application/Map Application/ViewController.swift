//
//  ViewController.swift
//  Map Application
//
//  Created by Shreya Chatterjee on 21/07/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func nextButton(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "MapView", bundle: nil)
        let mapVC = storyBoard.instantiateViewController(withIdentifier: "InitialNavigationController") as! UINavigationController
        mapVC.modalPresentationStyle = .fullScreen
        mapVC.modalTransitionStyle = .crossDissolve
        self.present(mapVC, animated: true, completion: nil)
    }


}

