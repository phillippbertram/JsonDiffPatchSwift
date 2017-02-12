//
//  Tests.swift
//  Tests
//
//  Created by Phillipp Bertram on 12/02/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON

@testable import JsonDiffPatch

func jsonString(forFileName fileName: String) -> String {
    guard let path = Bundle(for: JsonDiffPatchSpec.self)
        .path(forResource: fileName, ofType: "json") else {
            return ""
    }
    
    do {
        return try String(contentsOfFile: path)
    } catch {
        return ""
    }
    
}

func jsonDict(forFileName fileName: String) -> [String: Any] {
    let string = jsonString(forFileName: fileName)
    guard let data = string.data(using: .utf8) else {
        return [:]
    }
    let json = try? JSONSerialization.jsonObject(with: data, options: [])
    if let json = json as? [String: Any] {
        return json
    }
    return [:]
}

func asJsonString(dict: [String: Any]) -> String {
    do {
        let data = try JSONSerialization.data(withJSONObject: dict)
        return String(data: data, encoding: .utf8) ?? ""
    } catch {
        return ""
    }
}

class JsonDiffPatchSpec: QuickSpec {
    
    override func spec() {
        
        describe("JsonDiffPatch") {
            
            context("diff") {
                
                it("complex") {
                    
                    // given
                    let left = jsonString(forFileName: "left")
                    let right = jsonString(forFileName: "right")
                    let expected = JSON.parse(jsonString(forFileName: "expected"))
                
                    // when
                    let delta = JsonDiffPatch.delta(source: left, target: right)

                    // then
                    expect(JSON(delta)) == expected
                    
                }
                
            }
            
        }
        
    }
    
}
