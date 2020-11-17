//
//  LogModelProtocol.swift
//  RaLog
//
//  Created by Rakuyo on 2020/9/27.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import Foundation

/// Log Data Protocol.
///
/// Used to restrict the data fields that a log data type must contain.
public protocol LogModelProtocol: class, Codable {
    
    /// The raw data object to be printed by the user.
    var log: Any? { get set }
    
    /// Use `"nil"` to unpack the `log` attribute.
    var safeLog: String { get }
    
    /// The name of the module to which the log belongs.
    var module: String { get set }
    
    /// The name of the file to which the log belongs.
    var file: String { get set }
    
    /// The name of the function in which the log is located.
    var function: String { get set }
    
    /// The line number where the log is located.
    var line: Int { get set }
    
    /// Flag of log.
    var flag: Log.Flag { get set }
    
    /// The time stamp when the model was created.
    ///
    /// It can also be understood as the time to print this log.
    var timestamp: TimeInterval { get set }
    
    /// Content after `timestamp` formatted.
    var formatTime: String { get }
    
    /// The output in the console.
    var logedStr: String { get set }
}
