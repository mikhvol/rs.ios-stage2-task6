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
@property (strong, nonatomic) UIStackView* figuresStackView;
@property (strong, nonatomic) NSArray* portraitConstraints;
@property (strong, nonatomic) NSArray* landscapeConstraints;

@end

@implementation ViewController

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    if (size.height < size.width) {
        [NSLayoutConstraint deactivateConstraints:self.portraitConstraints];
        [NSLayoutConstraint activateConstraints:self.landscapeConstraints];
    } else if (size.height >= size.width) {
        [NSLayoutConstraint deactivateConstraints:self.landscapeConstraints];
        [NSLayoutConstraint activateConstraints:self.portraitConstraints];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hex:@"0xFFFFFF"];
    [self setupViews];
    [self activateConstraints];
}

- (void) setupViews {
    self.areYouReady = [[UILabel alloc] init];
    self.areYouReady.text = @"Are you ready?";
    self.areYouReady.adjustsFontSizeToFitWidth = YES;
    [self.areYouReady setTextColor:[UIColor hex:@"0x101010"]];
    self.areYouReady.textAlignment = NSTextAlignmentCenter;
    [self.areYouReady setFont:[UIFont systemFontOfSize:24.0 weight:UIFontWeightMedium]];
    self.areYouReady.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.areYouReady];
    
    [self customizeFiguresStackView];
        
    self.start = [[UIButton alloc] init];
    self.start.backgroundColor = [UIColor hex:@"0xF9CC78"];
    self.start.layer.cornerRadius = 27.5;
    self.start.clipsToBounds = YES;
    [self.start setTitle:@"START" forState:UIControlStateNormal];
    [self.start setTitleColor:[UIColor hex:@"0x101010"] forState:UIControlStateNormal];
    [self.start.titleLabel setFont:[UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium]];
    self.start.translatesAutoresizingMaskIntoConstraints = NO;
    [self.start addTarget:self action:@selector(presentTabBarController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.start];
}

- (void) setupTabBarController:(UITabBarController*)tabBarVC {
    self.tabBarController = tabBarVC;
    self.tabBarController.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)activateConstraints {
    self.portraitConstraints = @[
        [self.areYouReady.heightAnchor constraintEqualToConstant:80],
        [self.areYouReady.widthAnchor constraintEqualToConstant:200],
        [self.areYouReady.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.areYouReady.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:70],
        [self.figuresStackView.heightAnchor constraintEqualToConstant:100],
        [self.figuresStackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.figuresStackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.figuresStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-80],
        [self.start.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:140],
        [self.start.heightAnchor constraintEqualToConstant:55],
        [self.start.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [self.start.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20]
    ];
    
    self.landscapeConstraints = @[
        [self.areYouReady.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.areYouReady.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:60],
        [self.figuresStackView.heightAnchor constraintEqualToConstant:100],
        [self.figuresStackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.figuresStackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.figuresStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-20],
        [self.start.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:120],
        [self.start.heightAnchor constraintEqualToConstant:55],
        [self.start.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:80],
        [self.start.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-80]
    ];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
    [NSLayoutConstraint activateConstraints:self.portraitConstraints];
    } else {
    [NSLayoutConstraint activateConstraints:self.landscapeConstraints];
    }
}

- (void) customizeFiguresStackView {
    self.circle = [[CircleView alloc] init];
    self.circle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.circle.heightAnchor constraintEqualToConstant:70].active = YES;
    [self.circle.widthAnchor constraintEqualToConstant:70].active = YES;
    
    self.rectangle = [[RectangleView alloc] init];
    self.rectangle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rectangle.heightAnchor constraintEqualToConstant:70].active = YES;
    [self.rectangle.widthAnchor constraintEqualToConstant:70].active = YES;
    
    self.triangle = [[TriangleView alloc] init];
    self.triangle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.triangle.heightAnchor constraintEqualToConstant:70].active = YES;
    [self.triangle.widthAnchor constraintEqualToConstant:70].active = YES;
    
    self.figuresStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.circle, self.rectangle, self.triangle]];
    self.figuresStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.figuresStackView.axis = UILayoutConstraintAxisHorizontal;
    self.figuresStackView.alignment = UIStackViewAlignmentCenter;
    self.figuresStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.figuresStackView.layoutMargins = UIEdgeInsetsMake(0, 50, 0, 50);
    [self.figuresStackView setLayoutMarginsRelativeArrangement:YES];
    [self.view addSubview:self.figuresStackView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//MARK: - Actions

- (void) presentTabBarController {
    [self presentViewController:self.tabBarController animated:YES completion:nil];
    self.tabBarController.selectedIndex = 1;
}

@end
