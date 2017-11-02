//
//  ViewController.swift
//  DecoratorPattern
//
//  Created by SWC on 11/2/17.
//  Copyright © 2017 SWC. All rights reserved.
//

import UIKit

// DECORATOR PATTERN: -
// Allows you to add behaviors to objects while not requiring
// all objects to adopt the behaviors.

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Decorator implementation
        
        let dialer = DefaultDialer()
        
        // If you'd like to call people on their other number
        // after not reaching their first number
        let followUpCallDialerDecorator = FollowupCallDialerDecorator(dialer: dialer)
        
        // If you'd like to call peoples' cell phones after not reaching them on landlines
        let cellPhoneDialer = CellPhoneDialerDecorator(dialer: followUpCallDialerDecorator)
        
        // To text cell phones if not able to reach them via calls
        let textMe = TextMeDecorator(dialer: cellPhoneDialer)
        textMe.contactAction() // Contact action to implement all contact methods

    }

}


// MARK: DialerInterface protocol

protocol DialerInterface {
    func contactAction()
}


// MARK: DefaultDialer

struct DefaultDialer: DialerInterface {
    
    func contactAction() {
        
        print("--------Begin---------")
        print("Default Dialing Action completed")
        
    }
    
}


// MARK: - FollowupCalDialerlDecorator

struct FollowupCallDialerDecorator: DialerInterface {
    
    // Since the decorator adheres to the DialerInterface protocol
    // we are able to use the old functionality as-is while
    // adding a new behavior.

    let dialer: DialerInterface
    
    init(dialer: DialerInterface) {
        self.dialer = dialer // Takes the original dialer object in the constructor.
    }
    
    func contactAction() {
        dialer.contactAction()
        
        print("----------Followup Call-------------")
        print("Followup Dialing Action completed")

    }
}


// MARK: - CellPhoneDialerDecorator

struct CellPhoneDialerDecorator: DialerInterface {
    
    let dialer: DialerInterface
    
    init(dialer: DialerInterface) {
        self.dialer = dialer
    }
    
    func contactAction() {
        dialer.contactAction()
        
        print("--------Text----------")
        print("Cell Phone Action completed")

    }
    
}


// MARK: - TextMeDecorator

struct TextMeDecorator: DialerInterface {
    let dialer: DialerInterface
    
    init(dialer: DialerInterface) {
        self.dialer = dialer
    }
    
    func contactAction() {
        dialer.contactAction()
        
        print("-------Text---------")
        print("Text Me Action completed")

    }
    
}







