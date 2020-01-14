//
//  settingsViewController.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-04-02.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    
    @IBOutlet var usernameLabel:UILabel!
    @IBOutlet var passwordLabel:UILabel!
    @IBOutlet var identityLabel:UILabel!
    @IBOutlet var engineSwitch:UISwitch!
    @IBOutlet var agreementFactorSlider:UISlider!
    
    
    func refreshFields() {
        let defaults = UserDefaults.standard
        usernameLabel.text = defaults.string(forKey: nameKey)
        passwordLabel.text = defaults.string(forKey: passwordKey)
        identityLabel.text = defaults.string(forKey: identityKey)
        engineSwitch.isOn = defaults.bool(forKey: agreementKey)
        agreementFactorSlider.value = defaults.float(forKey: agreementFactorKey)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFields()
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(notification:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: app)
        
    }
    
    @IBAction func onEngineSwitchTapped(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(engineSwitch.isOn, forKey: agreementKey)
        defaults.synchronize()
    }
    @IBAction func onWarpSliderDragged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(agreementFactorSlider.value, forKey: agreementFactorKey)
        defaults.synchronize()
    }
    
    @IBAction func onSettingsButtonTapped(_ sender: AnyObject) {
        let application = UIApplication.shared
        let url = URL(string: UIApplicationOpenSettingsURLString)! as URL
        if application.canOpenURL(url) {
            application.open(url, options:["":""] , completionHandler: nil)
        }
    }
    
    func applicationWillEnterForeground(notification:NSNotification) {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        refreshFields()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
