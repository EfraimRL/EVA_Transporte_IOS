//
//  SplashScreen.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 25/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {

    @IBOutlet weak var progressBat: UIProgressView!
    var timer = Timer()
    var count:Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressBat.progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,      selector: #selector(timerRunning), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func timerRunning() {
        count += 0.1
        if count <= 1 {
            self.progressBat.setProgress(count, animated: false)
        }
        else{
            performSegue(withIdentifier: "segASignIn", sender: nil)
            timer.invalidate()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
