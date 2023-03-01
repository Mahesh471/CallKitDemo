//
//  CallManager.swift
//  CallKitDemo
//
//  Created by Mahesh on 23/02/23.
//

import UIKit
import CallKit

class CallManager: NSObject, CXProviderDelegate, CXCallObserverDelegate {
    let provider = CXProvider(configuration: CXProviderConfiguration())
    let callController = CXCallController()
    let uuid = UUID()
    var callObserver = CXCallObserver()

    override init() {
        super.init()
        provider.setDelegate(self, queue: nil)
        callObserver.setDelegate(self, queue: nil)
    }
    
    //MARK: Methods for CallKit fuctionality
    func reportIncommingCall(id: UUID, handle: String) {
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: handle)
        provider.reportNewIncomingCall(with: id, update: update) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Incomming call reported....")
            }
        }
    }
    
    func startCall(id: UUID, handle: String) {
        let handle = CXHandle(type: .generic, value: handle)
        let action = CXStartCallAction(call: id, handle: handle)
        let transactions = CXTransaction(action: action)
        callController.request(transactions) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Call started....")
            }
        }
    }
    
    func endCall(id: UUID) {
        let action = CXEndCallAction(call: id)
        let transactions = CXTransaction(action: action)
        callController.request(transactions) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Call ended....")
            }
        }
    }
    
    //MARK: Provider Delegate
    func providerDidReset(_ provider: CXProvider) {
        print(provider.description)
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
    }
    
    //MARK: Call Observer
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.isOutgoing == true && call.hasConnected == false && call.hasEnded == false {
            print("detect a dialing outgoing call")
        }
        
        if call.isOutgoing == true && call.hasConnected == true && call.hasEnded == false {
            print("outgoing call in process")
        }
        
        if call.isOutgoing == false && call.hasConnected == false && call.hasEnded == false {
            print("incoming call ringing (not answered)")
        }
        
        if call.isOutgoing == false && call.hasConnected == true && call.hasEnded == false {
            print("incoming call in process")
        }
        
        if call.isOutgoing == true && call.hasEnded == true {
            print("outgoing call ended.")
        }
        
        if call.isOutgoing == false && call.hasEnded == true {
            print("incoming call ended.")
        }
        
        if call.hasConnected == true && call.hasEnded == false && call.isOnHold == false {
            print("call connected (either outgoing or incoming)")
        }
        
        if call.isOutgoing == true && call.isOnHold == true {
            print("outgoing call is on hold")
        }
        
        if call.isOutgoing == false && call.isOnHold == true {
            print("incoming call is on hold")
        }
    }
}
