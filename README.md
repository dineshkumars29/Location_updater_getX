# location_updater

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Task:

Local Notification
Step1:
IOS -> Runner -> AppDelecate -> add some lines

import flutter_local_notifications

FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
GeneratedPluginRegistrant.register(with: registry)}

    if #available(iOS 10.0, *) {
         UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
