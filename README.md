# JsonDiffPatchSwift

[![Swift Version](https://img.shields.io/badge/Swift-3.0-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
![Version](https://img.shields.io/cocoapods/v/JsonDiffPatchSwift.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Just a simple Swift wrapper for https://github.com/benjamine/jsondiffpatch


## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

To integrate `JsonDiffPatchSwift` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'JsonDiffPatchSwift', '~> 1.0.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.

```swift
dependencies: [
    .Package(url: "https://github.com/PhillippBertram/JsonDiffPatchSwift.git", majorVersion: 1)
]
```

```
$ swift build
```

## Usage

This library just uses apples native `JavaScriptCore` framework [JSContext](https://developer.apple.com/reference/javascriptcore/jscontext) to wrap https://github.com/benjamine/jsondiffpatch into swift by evaluating javascript code. 
Currently there is only one function provided by `jsondiff.json` called `delta`. That function requires two json strings and creates the appropriate delta generated by the jsondiffpatch library.

### Example

**left.json**
```json
{"menu": {
  "id": "file",
  "value": "File",
  "popup": {
    "menuitem": [
      {"value": "New", "onclick": "CreateNewDoc()"},
      {"value": "Open", "onclick": "OpenDoc()"},
      {"value": "Close", "onclick": "CloseDoc()"}
    ]
  }
}}
```


**right.json**
```json
{"menu": {
  "id": "file",
  "value": "File",
  "popup": {
    "menuitem": [
      {"value": "New", "onclick": "CreateNewDoc()"},
      {"value": "Save", "onclick": "SaveDoc()"}
    ]
  }
}}
```

```swift
import JsonDiffPatchSwift

let left: String = // ...
let right: String = // ...

let delta: [String: Any] = JsonDiffPatch.delta(source: left , target: right)

// or alternatively with error handling
do {
  let delta = try JsonDiffPatch.deltaOrFail(source: left, target: right)
} catch {
  // handle error
}

```

**delta**
```json
{
  "menu": {
    "popup": {
      "menuitem": {
        "1": {
          "value": [
            "Open",
            "Save"
          ],
          "onclick": [
            "OpenDoc()",
            "SaveDoc()"
          ]
        },
        "_t": "a",
        "_2": [
          {
            "value": "Close",
            "onclick": "CloseDoc()"
          },
          0,
          0
        ]
      }
    }
  }
}
```
