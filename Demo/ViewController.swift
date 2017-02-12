//
//  ViewController.swift
//  Demo
//
//  Created by Phillipp Bertram on 12/02/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import UIKit
import JsonDiffPatch

class ViewController: UIViewController {

    @IBOutlet weak var leftTextView: UITextView!
    @IBOutlet weak var rightTextView: UITextView!
    @IBOutlet weak var deltaTextView: UITextView!
    
    @IBAction func generateDelta(_ sender: Any) {
        let leftJson = leftTextView.text!
        let rightJson = rightTextView.text!
        let delta = JsonDiffPatch.delta(source: leftJson, target: rightJson)
        
        deltaTextView.text = delta.jsonString
    }
}

