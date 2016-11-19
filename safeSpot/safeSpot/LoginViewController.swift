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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func presentLogin(sender: UIButton) {
        let controller = A0Lock.sharedLock().newLockViewController()

        controller.closable = true
        controller.onAuthenticationBlock = { profile, token in
            
            print("token", token)
            print("profile", profile)
            
            //            let VC1 = self.storyboard?.instantiateViewControllerWithIdentifier("SafeSpot") as! ViewController
            //            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
            //            self.presentViewController(navController, animated:true, completion: nil)
//            self.next()
            controller.dismissViewControllerAnimated(true, completion: nil)
//            self.performSegueWithIdentifier("initial", sender: nil)
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SafeSpot") as! ViewController
            self.presentViewController(secondViewController, animated: true, completion: nil)
            
        }
        A0Lock.sharedLock().presentLockController(controller, fromController: self)
    }

    func next() {
        let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SafeSpot") as! ViewController
        self.presentViewController(secondViewController, animated: true, completion: nil)
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
