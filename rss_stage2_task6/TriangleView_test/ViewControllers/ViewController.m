//
//  ViewController.m
//  TriangleView_test
//
//  Created by worker on 20/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import "ViewController.h"
#import "TriangleView.h"
#import "UIColor+ColorExtension.h"
#import "CircleView.h"
#import "RectangleView.h"

@interface ViewController ()

@property (strong, nonatomic) UILabel* areYouReady;
@property (strong, nonatomic) CircleView* circle;
@property (strong, nonatomic) RectangleView* rectangle;
@property (strong, nonatomic) TriangleView* triangle;
@property (strong, nonatomic) UIButton* start;
@property (strong, nonatomic) UITabBarController* tabBarController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hex:@"0xFFFFFF"];
    [self setupViews];
}

- (void) setupViews {
    
    self.areYouReady = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 70)];
    self.areYouReady.center = CGPointMake(self.view.center.x, self.view.center.y * 0.4);
    self.areYouReady.text = @"Are you ready?";
    [self.areYouReady setTextColor:[UIColor hex:@"0x101010"]];
    self.areYouReady.textAlignment = NSTextAlignmentCenter;
    [self.areYouReady setFont:[UIFont systemFontOfSize:24.0 weight:UIFontWeightMedium]];
    [self.view addSubview:self.areYouReady];
    
    self.circle = [[CircleView alloc] init];
    self.circle.center = CGPointMake(self.view.center.x * 0.45, self.view.center.y * 0.8);
    [self.view addSubview:self.circle];
    
    self.rectangle = [[RectangleView alloc] init];
    self.rectangle.center = CGPointMake(self.view.center.x, self.view.center.y * 0.8);
    [self.view addSubview:self.rectangle];
    
    self.triangle = [[TriangleView alloc] init];
    self.triangle.center = CGPointMake(self.view.center.x * 1.55, self.view.center.y * 0.8);
    [self.view addSubview:self.triangle];
    
    self.start = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.75, 55)];
    self.start.center = CGPointMake(self.view.center.x, self.view.center.y * 1.5);
    self.start.backgroundColor = [UIColor hex:@"0xF9CC78"];
    self.start.layer.cornerRadius = 27.5;
    self.start.clipsToBounds = YES;
    [self.start setTitle:@"START" forState:UIControlStateNormal];
    [self.start setTitleColor:[UIColor hex:@"0x101010"] forState:UIControlStateNormal];
    [self.start.titleLabel setFont:[UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium]];
    
    [self.start addTarget:self action:@selector(presentTabBarController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.start];
    
}

- (void) setupTabBarController:(UITabBarController*)tabBarVC {
    self.tabBarController = tabBarVC;
    self.tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//MARK: - Actions

- (void) presentTabBarController {
    [self presentViewController:self.tabBarController animated:YES completion:nil];
}

@end
