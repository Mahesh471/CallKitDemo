//
//  ViewController.swift
//  CallKitDemo
//
//  Created by Mahesh on 23/02/23.
//

import UIKit

class ViewController: UIViewController {
    let callManager = CallManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    //MARK: Methods
    func reportingIncommingCall() {
        callManager.reportIncommingCall(id: callManager.uuid, handle: "Tom Calling...")
    }

    func startCall() {
        callManager.startCall(id: callManager.uuid, handle: "Tom Cruse")
    }
    
    func endCall() {
        callManager.endCall(id: callManager.uuid)
    }
    
    //MARK: Button Actions
    @IBAction func startCallAction(_ sender: Any) {
        startCall()
    }
    
    @IBAction func endCallAction(_ sender: Any) {
        endCall()
    }
    
    //MARK: Methods for motion guesture
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            reportingIncommingCall()
        }
    }
}

