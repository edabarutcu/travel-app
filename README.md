# FMSS Bilişim iOS Swift Bootcamp - Final Project

# Travel App✈️🏖

The travel guide application is the application where we can have information about the places to go. An application where we can add the trips we plan to go in the near future.

## For Developers

```
git clone https://github.com/edabarutcu/travel-app.git
cd TravelApp
open TravelApp.xcworkspace
```

## ScreenShot

<div style="display: flex; gap: 100px;">
  <img src="https://user-images.githubusercontent.com/91742636/195174243-ecbbc605-912d-44e2-840f-a917d9412a35.png" alt="drawing" width="249"/> 
   <img src="https://user-images.githubusercontent.com/91742636/195172707-57a8a4c3-e04f-4f43-a6fc-1161ddff4e89.png" alt="drawing" width="249"/> 
      <img src="https://user-images.githubusercontent.com/91742636/195174675-fb70e31b-753c-44c8-8939-3e0aff33ab4d.png" alt="drawing" width="249"/> 
   <img src="https://user-images.githubusercontent.com/91742636/195172860-9b60b3ac-5ff0-4eaf-8020-502aeb9d0784.png" alt="drawing" width="249"/> 
    <img src="https://user-images.githubusercontent.com/91742636/195173048-f962b65c-9246-4afb-9b60-d4e209702562.png" alt="drawing" width="249"/> 
      <img src="https://user-images.githubusercontent.com/91742636/195175326-e5f25d0a-2733-48fd-b5a4-35a5822ce9dd.png" alt="drawing" width="249"/> 
       <img src="https://user-images.githubusercontent.com/91742636/195175579-2b3f4aed-7567-4fc3-b773-89cb0db7c78f.png" width="249"/> 
        <img src="https://user-images.githubusercontent.com/91742636/195175793-bca41e0c-a1be-4a1d-a7d7-67a2f0d7580b.png" width="249"/> 
         <img src="https://user-images.githubusercontent.com/91742636/195175963-4af6f1ef-1cd6-45ab-a580-150e2307061a.png" width="249"/> 
           <img src="https://user-images.githubusercontent.com/91742636/195176166-6808bcfb-3f36-4e25-9282-b0f8a3331fa1.png" width="249"/>  
           <img src="https://user-images.githubusercontent.com/91742636/195179691-702f08e6-b24f-4411-9868-ccc005713800.png" width="249"/> 
           <img src="https://user-images.githubusercontent.com/91742636/195179798-7eb308ef-e89c-4b6e-b220-de307de80b90.png" width="249"/> 
</div> 


## Requirement
- Xcode 13.2.1
- iOS 15.2
- Swift 5 +

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
        return hashed.description.components(separatedBy: ":")[1]
    }
 ```
 
 


