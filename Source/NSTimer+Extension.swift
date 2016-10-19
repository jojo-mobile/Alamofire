//
//  NSTimer+Extension.swift
//  Alamofire
//
//  Created by Jakub on 19/10/16.
//  Copyright © 2016 Alamofire. All rights reserved.
//

import Foundation

public typealias FLTimerBlock = (timeinterval:NSTimeInterval) -> Void

extension NSTimer
{
    private class TimerBlockContainer {
        private(set) var timerBlock:FLTimerBlock
        
        init( timerBlock:FLTimerBlock ) {
            self.timerBlock = timerBlock;
        }
    }
    
    public class func scheduledTimerWithTimeInterval(timeInterval:NSTimeInterval,
                                                     repeats:Bool = false,
                                                     block:FLTimerBlock) -> NSTimer
    {
        return self.scheduledTimerWithTimeInterval(timeInterval,
                                                   target: self,
                                                   selector:"_executeBlockFromTimer:",
                                                   userInfo:TimerBlockContainer(timerBlock:block),
                                                   repeats:repeats)
    }
    
    @objc class func _executeBlockFromTimer( timer:NSTimer ) {
        if let timerBlockContainer = timer.userInfo as? TimerBlockContainer {
            timerBlockContainer.timerBlock(timeinterval:timer.timeInterval)
        }
    }
}