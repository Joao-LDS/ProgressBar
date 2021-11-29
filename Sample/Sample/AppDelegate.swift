//
//  AppDelegate.swift
//  SandBox
//
//  Created by TLSP-000092 on 25/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = SandBoxViewController()
		window?.makeKeyAndVisible()
		return true
	}
}

