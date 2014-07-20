# NDNavigator #

URL --> UIViewController mapping and navigation utilities

## Work In Progress ##

The code and this README are currently work-in-progress. Many of the features are experimental in both design and execution and as such are subject to rapid change. It's also possible this project could be abandoned at any time.

## Overview ##

NDNavigator intends to facilitate navigation using URLs in an iOS application. This includes support for internal navigation as well as external 'URL schemes'

It is similar in scope to the TTNavigator component in the (discontinued) [Three20](https://github.com/facebookarchive/three20) library, but takes a different approach.

## Design Considerations ##

The design takes inspiration from an apparently dead [proposal](https://github.com/jverkoey/nimbus/issues/10) to provide an alternative to TTNavigator in [NimbusKit](http://nimbuskit.info/), which itself aims to be a replacement for the Three20 framework, but currently lacks a navigation component, presumably by design.

In common with that proposal, NDNavigator aims to be complementary to UIKit, enabling a 'mix & match' approach when building your apps. It is not meant to form the central core of an application, although it may be utilized in that core. 

The task of view controller instantiation can be left to other parts of the application. Although NDNavigator will attempt to create the view controllers if the client doesn't specify an external factory, the expectation is that a factory will be supplied. The example application demonstrates use of a simple home-grown factory, the excellent [Typhoon Framework](http://www.typhoonframework.org/) as well as no factory (switchable in the Settings bundle)

Also in common is the use of [SOCkit](https://github.com/NimbusKit/sockit) to provide pattern matching in the path component of URLs. 

Differences include:

1. Only the 'path' component of the URL is considered for pattern matching.
2. The view controller class is resolved from the 'host' component of the UR
3. The 'scheme' component of the URL is ignored.
4. The URL query parameters will NOT be passed to the 'willNavigateSelector' even if it takes more arguments than tokens matched in the path pattern.

## Limitations ##

Amongst others, some of the major current limitations

1. 'Outbound' support only. View controllers can be created from URLs and have selectors performed on them. However there is currently no 'inbound' support to convert a view controller (or navigation hierarchy) into a URL string, for e.g. UI state persistence.
2. No Storyboard support.
3. No test code yet.

## Usage ##
TODO: See the supplied example app for now. 

The example app uses [CocoaPods](http://cocoapods.org/) to pull down the Typhoon and SOCKit dependencies

## TODO: ##
1. Unit tests
2. CocoaPod
3. Inbound support
4. Additional category support to enable other navigation paradigms
5. Storyboard support
6. Multiple URL scheme support
