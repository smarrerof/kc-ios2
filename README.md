# Madrid Shopping
Práctica de iOS Avanzado con Swift 4 del V KeepCoding Startup Engineering Master Bootcamp (2017)

## Goals
Create a mobile application to display information of Shops in Madrid, even when the user has no Internet connection. Shops should be shown in a Map.

## Requirements
1. When starting the App for the first time, if there's Internet connection it will download all information from the Shops access
point (see below), including all images.
2. The App will cache everything locally: images, data, etc. Even images of the maps. See below for tips.
3. Cache is never invalidated, so once everything has been saved, set a flag and never ever access to the network again.
4. If there's no Internet connection a message will be shown to the user.
5. While caching the App will show an Activity indicator or other loader. Until you finish caching you don't get to the Main menu.
6. The app will have a main menu screen where we'll add one button & a logo. The button takes us to the list of shops.
7. The list of Shops will show in the upper 50% screen a map with one pin for each shop.
8. The list of Shops will show in the lower 50% screen. Logo to the left, background image taking all the row, shop name in the front. Tapping a row takes us to the detail shop screen.
9. All info should be read from a Core Data database.
10. If you tap on a pin in the map a callout will open with the logo + shop name. Taping the callout takes us to the detail shop screen.
11. The map will be always centered in madrid, showing also the user location.
12. All data is at least in Spanish & English: should cache all and display in Spanish (if that's our phone's language) or English otherwise
13. Shop detail screen should show shop name, description, address, and a map showing the shops's location without any pin.


## Installation
To install the application execute the next commands
```
$ git clone https://github.com/smarrerof/kc-ios2
$ cd kc-ios2
$ open MadridShops.xcodeproj
```

Run and enjoy the app in your favorite emulator or in your device

The app has been tested in **iOS 10 and iOS11**.

## 
1. CoreData is used as cache. Shops and actvities are saved in CoreData when the app runs for the firt time. Logo, image and static map for each Shop/Activity are stored in CoreData as well.
2. Shop/Activity list and detail is shown with only one ViewController. Access to CoreDate is managed by a class that uses a generic class to access to the correct table. This class can be extended to accept filters.
3. CocoaPod is not used, so access to network is managed by a custom class.
4. A red border is added as background image to each cell.
5. Download and cache shops and activities are is custom classes because each entity can download more information that the information that is abstracted in the entity/model classes. At this moment this information is the same, but more viewcontrollers can be added to use this extended information. 

### Demo
![MadridShops Demo](https://raw.githubusercontent.com/smarrerof/kc-ios2/master/madridapp-ios.gif)