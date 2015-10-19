# BIVerify

## Installing

Something to do with CocoaPods - I don't know how it works yet.

## Usage

```
import BIVerify
let intent = BIVerify.expressIntent('GET', action: '/foo', parameters: [:])
let action = intent.sign('secret')
print(action.signedPath)
```
