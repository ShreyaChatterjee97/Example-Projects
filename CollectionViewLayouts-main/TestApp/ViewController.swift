//
//  ViewController.swift
//  TestApp
//
//  Created by Shreya Chatterjee on 20/07/22.
//

import UIKit

class ViewController: UIViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemBlue
    
    }

    @IBAction func nextButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "CollectionViewStoryboard", bundle: nil)
        let collectionVC = storyBoard.instantiateViewController(withIdentifier: "collectionViewStoryboard") as! CollwctionViewController
        collectionVC.modalPresentationStyle = .fullScreen
        collectionVC.modalTransitionStyle = .crossDissolve
        self.present(collectionVC, animated: true, completion: nil)
    }
    
}

