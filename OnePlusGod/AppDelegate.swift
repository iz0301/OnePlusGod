//
//  AppDelegate.swift
//  OnePlusGod
//
//  Created by Isaac Zachmann on 3/14/18.
//  Copyright © 2018 Isaac Zachmann. All rights reserved.
//

import UIKit
import UserNotifications
import CFNetwork

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var server = "https://ironic-objectivist-202915.appspot.com";
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:       [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = .blue;
        UINavigationBar.appearance().tintColor = .white;
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white];
        
        UITabBar.appearance().barTintColor = .blue;
        UITabBar.appearance().tintColor = .gray;
        UITabBar.appearance().unselectedItemTintColor = .white;
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        UITableViewHeaderFooterView.appearance().tintColor = .blue;
        
        // Construct inital view, create a window
        window = UIWindow(frame: UIScreen.main.bounds);
        
        let notificationCenter = UNUserNotificationCenter.current();
        notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: { (success, error) in
            if success {
                print("Notifications enabled");
            } else {
                print("Warning: Notifications not enabled!");
            }
        });
        // new thread to schedlue notifications in background (one now and then every 5 minutes)
        DispatchQueue.global(qos: .background).async {
            for notificationRequest in LocalNotificationHandler.retreiveNotifications() {
                notificationCenter.add(notificationRequest, withCompletionHandler: {
                    (error) in
                    if(error != nil){
                        print("Error setting notifications:" + error.debugDescription);
                    }
                });
                //print("Set Notification: " + notificationRequest.content.title);
            }
            /*notificationCenter.getPendingNotificationRequests(completionHandler:
             {(requests) in
             for not in requests {
             print("Waiting for: " + not.content.title);
             }
             print("$$$$$$$$$$AHHH####");
             }
             );*/
        }
        Timer.scheduledTimer(withTimeInterval: TimeInterval(300), repeats: true, block: {(timer) in
            DispatchQueue.global(qos: .background).async {
                for notificationRequest in LocalNotificationHandler.retreiveNotifications() {
                    notificationCenter.add(notificationRequest, withCompletionHandler: {
                        (error) in
                        if(error != nil){
                            print("Error setting notifications:" + error.debugDescription);
                        }
                    });
                }
            }
        });
        
        let tabs = UITabBarController();
        
        //Set up the navagation controllers for each tab:
        let newsNav = UINavigationController();
        newsNav.title = "News";
        newsNav.addChildViewController(News());
        
        let registerNav = UINavigationController();
        registerNav.title = "Register";
        registerNav.addChildViewController(Register());
        
        let requestNav = UINavigationController();
        requestNav.title = "Request";
        requestNav.addChildViewController(Request());
        
        let donateNav = UINavigationController();
        donateNav.title = "Donate";
        donateNav.addChildViewController(Donate());
        
        let storeNav = UINavigationController();
        storeNav.title = "Store";
        storeNav.addChildViewController(Store());
        
        tabs.setViewControllers([ newsNav, registerNav, requestNav, donateNav, storeNav ], animated: true);
        tabs.tabBar.items?[0].image = #imageLiteral(resourceName: "NewsIcon");
        tabs.tabBar.items?[1].image = #imageLiteral(resourceName: "RegisterIcon");
        tabs.tabBar.items?[2].image = #imageLiteral(resourceName: "RequestIcon");
        tabs.tabBar.items?[3].image = #imageLiteral(resourceName: "DonateIcon");
        tabs.tabBar.items?[4].image = #imageLiteral(resourceName: "StoreIcon");
        
        window!.rootViewController = tabs;
        window!.makeKeyAndVisible();
        
        return true;
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

class LocalNotificationHandler {
    static func retreiveNotifications() -> [UNNotificationRequest] {
        var notifications : [UNNotificationRequest] = [];
        
        let myURLString = AppDelegate.server + "/app/notifications";
        do {
            let url = NSURL(string: myURLString);
            let data = try String(contentsOf: url! as URL, encoding: String.Encoding.utf8);
            let rawNewsData = data.components(separatedBy: "\n###EON###\n");
            var count = 1;
            for rawData in rawNewsData {
                if(rawData != ""){
                let notificationItem = UNMutableNotificationContent();
                let datas = rawData.components(separatedBy: "::");
                
                //ex date from server:        05/24/2016 15:43
                //let second = Int(datas[0].components(separatedBy: " ")[1].components(separatedBy: ":")[2]);
                let second = 0;
                let minute = Int(datas[0].components(separatedBy: " ")[1].components(separatedBy: ":")[1]);
                let hour = Int(datas[0].components(separatedBy: " ")[1].components(separatedBy: ":")[0]);
                let day = Int(datas[0].components(separatedBy: " ")[0].components(separatedBy: "/")[1]);
                let month = Int(datas[0].components(separatedBy: " ")[0].components(separatedBy: "/")[0]);
                let year = Int(datas[0].components(separatedBy: " ")[0].components(separatedBy: "/")[2]);
                let date = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second);
                
                notificationItem.title = String(datas[1]);
                notificationItem.body = String(datas[2]);
                notificationItem.sound = UNNotificationSound.default();
                
                let time = Calendar.current.date(from: date)?.timeIntervalSinceNow;
                if(!((time?.isLess(than: 0))!)){
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time!), repeats: false);
                    notifications.append(UNNotificationRequest(identifier: String(count), content: notificationItem, trigger: trigger));
                    count += 1;
                }
                }
            }
        } catch {
            print("Error getting scheduled notifications");
        }
        return notifications;
    }
    
}

