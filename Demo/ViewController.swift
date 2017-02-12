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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delta = JsonDiffPatch.diff(source: "{\"age\": 3}", target: "{\"age\": 5}")
        print("delta: \(delta)")
    }

}

