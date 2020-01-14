//
//  HomeViewController.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-03-17.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var naitWebView: UIWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let YoutubeLink = URL(string:"http://www.youtube.com/embed/HJDCl_Lcj7g")
        let naitRequest = URLRequest(url: YoutubeLink!)
        naitWebView?.loadRequest(naitRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
