//
//  TabBar_ViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 29/11/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class TabBar_ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
