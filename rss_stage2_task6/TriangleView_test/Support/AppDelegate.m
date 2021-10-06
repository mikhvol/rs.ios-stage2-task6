//
//  AppDelegate.m
//  TriangleView_test
//
//  Created by worker on 20/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GalleryViewController.h"
#import "InfoViewController.h"
#import "AboutViewController.h"
#import "UIColor+ColorExtension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow* window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    ViewController* vc = [[ViewController alloc] init];
    
    GalleryViewController* galleryViewController = [[GalleryViewController alloc] init];
    UINavigationController* galleryNavigationController = [[UINavigationController alloc] initWithRootViewController:galleryViewController];
    galleryNavigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"gallery_selected.pdf"];
    galleryNavigationController.tabBarItem.image = [UIImage imageNamed:@"gallery_unselected.pdf"];
    galleryNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [galleryNavigationController.navigationBar setBarTintColor:[UIColor hex:@"0xF9CC78"]];
    [galleryNavigationController.navigationBar setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor hex:@"0x101010"],
        NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]
    }];
    
    AboutViewController* aboutViewController = [[AboutViewController alloc] init];
    UINavigationController* aboutNavigationController = [[UINavigationController alloc] initWithRootViewController:aboutViewController];
    aboutNavigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected.pdf"];
    aboutNavigationController.tabBarItem.image = [UIImage imageNamed:@"home_unselected.pdf"];
    aboutNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [aboutNavigationController.navigationBar setBarTintColor:[UIColor hex:@"0xF9CC78"]];
    [aboutNavigationController.navigationBar setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor hex:@"0x101010"],
        NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]
    }];
    
    InfoViewController* infoViewController = [[InfoViewController alloc] init];
    UINavigationController* infoNavigationController = [[UINavigationController alloc] initWithRootViewController:infoViewController];
    infoNavigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"info_selected.pdf"];
    infoNavigationController.tabBarItem.image = [UIImage imageNamed:@"info_unselected.pdf"];
    infoNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [infoNavigationController.navigationBar setBarTintColor:[UIColor hex:@"0xF9CC78"]];
    [infoNavigationController.navigationBar setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor hex:@"0x101010"],
        NSFontAttributeName: [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]
    }];
    
    UITabBarController* tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[infoNavigationController, galleryNavigationController, aboutNavigationController];

    [vc setupTabBarController:tabBarController];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
