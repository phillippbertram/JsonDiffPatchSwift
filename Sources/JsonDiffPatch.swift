//
// Created by Phillipp Bertram on 2/6/17.
// Copyright (c) 2017 Viessmann Group. All rights reserved.
//

import Foundation
import JavaScriptCore

public final class JsonDiffPatch {

    /// JsonDiffPatchError
    ///
    /// - CouldNotCreateJSContext: Thrown, if JSConext() could not created
    /// - FailedLoadingJavaScript: Thrown, if the javascrip file coul not be loaded
    public enum JsonDiffPatchError: Error {
        case CouldNotCreateJSContext
        case FailedLoadingJavaScript
    }
    
    /// Creates a jsondiff dependent on given json parameters
    ///
    /// - Parameters:
    ///   - source: source JSON
    ///   - target: target JSON
    /// - Returns: json diff as dictionary
    public static func diff(source: String, target: String) throws -> [String: Any] {

        guard let context = JSContext() else {
            throw JsonDiffPatchError.CouldNotCreateJSContext
        }

        guard let path = Bundle(for: JsonDiffPatch.self).path(forResource: "jsondiff", ofType: "js") else {
            throw JsonDiffPatchError.FailedLoadingJavaScript
        }

        var output: [String: Any] = [:]
        do {
            // load jsondiff.js
            var jsSource: String = try String(contentsOfFile: path)
            jsSource = "var window = this; \(jsSource)"

            context.evaluateScript(jsSource)

            let diff = context.objectForKeyedSubscript("diff")!
            if let result = diff.call(withArguments: [source, target]).toDictionary() as? [String: Any] {
                output = result
            }

        } catch {
            throw JsonDiffPatchError.FailedLoadingJavaScript
        }

        return output
    }

}
