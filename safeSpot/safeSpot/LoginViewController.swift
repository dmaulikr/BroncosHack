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

        // adding seg to nav controller
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        let controller = A0Lock.sharedLock().newLockViewController()
        controller.closable = false
        controller.onAuthenticationBlock = { profile, token in
            // Do something with token  profile. e.g.: save them.
            // Lock will not save these objects for you.
            
           // self.usernameLabel.text = profile.name
            //self.emailLabel.text = profile.email
           // controller.sharedInstance.accessToken = token.accessToken
            // Don't forget to dismiss the Lock controller
            print("profile: ", profile, " token:", token)
            // MyApplication.sharedInstance.accessToken = token.accessToken
//            controller.dismissViewControllerAnimated(true, completion: nil)
            
//            let VC1 = self.storyboard?.instantiateViewControllerWithIdentifier("SafeSpot") as! ViewController
//            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
//            self.presentViewController(navController, animated:true, completion: nil)
 
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SafeSpot") as! ViewController
            self.navigationController!.pushViewController(secondViewController, animated: true)
            
        }
        A0Lock.sharedLock().presentLockController(controller, fromController: self)
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
