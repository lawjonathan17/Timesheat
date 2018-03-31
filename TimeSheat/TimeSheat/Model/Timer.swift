//
//  Timer.swift
//  TimeSheat
//
//  Created by Jonathan Law on 3/30/18.
//  Copyright © 2018 Jonathan Law. All rights reserved.
//

import Foundation

class Timer
{
    var timer: Timer? = nil
    var startTime: Date?
    var duration: TimeInterval = 360      // default = 6 minutes
    var elapsedTime: TimeInterval = 0
}
