# FMSS Bilişim iOS Swift Bootcamp - Final Project

# Travel App

## Network
 Hotel Api - https://developer.hotelbeds.com/documentation/getting-started/
 
 Flight Api - https://aviationstack.com
 
 ## Third Party Libraries 
 - Alamofire
 - SwiftyJson
 - SDWebImage
 
 ## Database
 - Core Data
 
 ## Architectural Pattern
 - MVVM
 
## Figma Link 
-  https://www.figma.com/file/WLJX33QX4BCP73bQLwBFBt/New-Travel-App---Responsive-UI-Shot-(Community)?node-id=1%3A81


## SHA256 hash in Hex format from your API Key, your secret plus current timestamps in seconds
#### X-Signature
 ```swift
     static func calculateXSignature() -> String {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let inputString = apiKey + secret + String(timestamp)
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)
        print(hashed.description.components(separatedBy: ":")[1])
        
        return hashed.description.components(separatedBy: ":")[1]
    }
 ```
 
 


