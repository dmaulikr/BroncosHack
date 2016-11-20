//
//  LoginViewController.swift
//  safeSpot
//
//  Created by Jessie Albarian on 11/19/16.
//  Copyright © 2016 teamAwesomeSauce. All rights reserved.
//

import UIKit
import Lock
import Auth0

class LoginViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func presentLogin(sender: UIButton) {
        let controller = A0Lock.sharedLock().newLockViewController()

        controller.closable = true
        controller.onAuthenticationBlock = { profile, token in

            controller.dismissViewControllerAnimated(true, completion: nil)
            
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SafeSpot") as! ViewController
            secondViewController.token = token
            self.presentViewController(secondViewController, animated: true, completion: nil)
        }
        A0Lock.sharedLock().presentLockController(controller, fromController: self)
    }
}
