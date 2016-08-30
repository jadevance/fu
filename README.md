# Fuzz Therapy ![](http://i.imgur.com/t0uI7tf.png =100x100)

This repository contains the iOS Swift code for my capstone project, Fuzz Therapy. It is an exploration in learning Swift 2.2 and backed by a custom Rails [API](https://github.com/jadevance/fuzz-therapy).

## Technologies and Concepts Explored

+ [Swift](https://en.wikipedia.org/wiki/Swift_(programming_language))
+ [Rails](https://en.wikipedia.org/wiki/Ruby_on_Rails)
+ [SSL](https://en.wikipedia.org/wiki/Transport_Layer_Security)
+ [DNS](https://en.wikipedia.org/wiki/Domain_Name_System)
+ [Oauth2](https://en.wikipedia.org/wiki/OAuth)

## Getting Started

1. Download XCODE 7.3 or higher
2. `git clone git@github.com:jadevance/fuzz-therapy-iOS.git`
3. `cd fuzz-therapy-iOS`
4. `pod install` (requires [CocoaPods](https://cocoapods.org))
5. Open `Fuzz Therapy.xcworkspace` in Xcode
6. probably have to convert Swift since 3.0 is coming out soon

## Important Caveats

1. Image data is saved as a JPEG, compressed and sent to a backend API running Rails 5 and the Paperclip gem. Changing the file conversion type is fine, but will require reconfiguration on both the app and API. 
2. This app assumes access to a Google account for oauth2 login.

## Contribution

Please feel free to contribute to this project by submitting a pull request or opening up an issue. This is my final project for ADA Developers Academy Cohort 5 in Seattle, WA.
