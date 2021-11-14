//
//  Log.swift
//  PokemonMVP
//
//  Created by Andoni Da silva on 30/10/21.
//

import CocoaLumberjackSwift
import CocoaLumberjack

enum LogLevel {
    case off
    case warning
    case info
    case debug
    case verbose
}

enum LogTag: CustomStringConvertible {
    case coreData
    case networking
    case decoding
    case state
    case navigation
    case app
    case presentation
    var description: String {
        switch self {
            case .coreData:
                return "Core Data"
            case .networking:
                return "Networking"
            case .decoding:
                return "Decoding"
            case .state:
                return "State"
            case .app:
                return "App"
            case .navigation:
                return "Navigation"
            case .presentation:
                return "Presentation"
        }
    }

    var shouldLogToFile: Bool {
        switch self {
            case .coreData, .networking:
                return true
            default:
                return false
        }
    }
}

enum PokemonMVPFlag: UInt {
    case app = 00000010
    case coreData = 00001000
}

enum Logger {
    static func configure(appVersion: String, logLevel: LogLevel) {
        let fileLevel = DDLogLevel(rawValue: 00001000) ?? .error
        DDLog.add(DDOSLogger.sharedInstance, with: fileLevel)
        let fileLogger = DDFileLogger()
        fileLogger.doNotReuseLogFiles = true
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger, with: fileLevel)
        pokemonMVPLog("---------- STARTED NEW RUN ---------- ✈️", tag: .state)
        pokemonMVPLog("---------- APP VERSION: \(appVersion) ---------- 📲", tag: .app)
    }
}

func pokemonMVPLog(
    _ message: @autoclosure () -> CustomStringConvertible,
    level: LogLevel = .debug,
    tag: LogTag,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
) {

    // Debug
        switch level {
            case .off: break
            case .warning:
                DDLogWarn(prettyMessage(message: message(), withTag: tag),
                          file: file,
                          function: function,
                          line: line,
                          tag: tag.description)
            case .info:
                DDLogInfo(prettyMessage(message: message(), withTag: tag),
                          file: file,
                          function: function,
                          line: line,
                          tag: tag.description)
            case .debug:
                DDLogDebug(prettyMessage(message: message(), withTag: tag),
                           file: file,
                           function: function,
                           line: line,
                           tag: tag.description)
            case .verbose:
                DDLogVerbose(prettyMessage(message: message(), withTag: tag),
                             file: file,
                             function: function,
                             line: line,
                             tag: tag.description)
        }
    }

func pokemonMVPLog(_ error: @autoclosure () -> Error,
              message: @autoclosure () -> String? = nil,
              tag: LogTag,
              file: StaticString = #file,
              function: StaticString = #function,
              line: UInt = #line) {
    // Debug
    if tag.shouldLogToFile {
        logToFile(prettyErrorMessage(error: error(), message: message(), tag: tag),
                  file: file,
                  function: function,
                  line: line,
                  tag: tag.description)
    } else {
        DDLogError(prettyErrorMessage(error: error(), message: message(), tag: tag),
                   file: file,
                   function: function,
                   line: line,
                   tag: tag.description)
    }
}

// MARK: - Private

private func logToFile(_ message: @autoclosure () -> Any,
                       level: DDLogLevel = DDLogLevel(rawValue: PokemonMVPFlag.app.rawValue) ?? DDLogLevel.error,
                       context: Int = 0,
                       file: StaticString,
                       function: StaticString,
                       line: UInt,
                       tag: Any? = nil,
                       ddlog _: DDLog = .sharedInstance)
{
    let logMessage = DDLogMessage(message: String(describing: message()),
                                  level: level,
                                  flag: DDLogFlag(level),
                                  context: context,
                                  file: String(describing: file),
                                  function: String(describing: function),
                                  line: line,
                                  tag: tag,
                                  options: DDLogMessageOptions(rawValue: 0),
                                  timestamp: nil)

    DDLog.log(asynchronous: true, message: logMessage)
}

private func prettyErrorMessage(error: Error, message: String? = nil, tag: LogTag) -> String {
    return prettyMessage(message: [message, String(describing: error)]
                            .compactMap { $0 }
                            .joined(separator: " — "),
                         withTag: tag)
}

private func prettyMessage(message: @autoclosure () -> CustomStringConvertible, withTag tag: LogTag) -> String {
    return "\(tag.description): \(message().description)"
}

