//
//  AboutViewController.m
//  TriangleView_test
//
//  Created by worker on 20/06/2020.
//  Copyright © 2020 Mike Volkov. All rights reserved.
//

#import "AboutViewController.h"
#import "TriangleView.h"
#import "CircleView.h"
#import "RectangleView.h"
#import "DivideLineView.h"
#import "UIColor+ColorExtension.h"

@interface AboutViewController ()

@property (strong, nonatomic) UIStackView* infoStackView;
@property (strong, nonatomic) UIStackView* figuresStackView;
@property (strong, nonatomic) UIStackView* buttonsStackView;
@property (strong, nonatomic) UIImageView* appleImageView;
@property (strong, nonatomic) UILabel* nameDeviceLabel;
@property (strong, nonatomic) UILabel* modelDeviceLabel;
@property (strong, nonatomic) UILabel* versionIosLabel;
@property (strong, nonatomic) UIButton* goToStartButton;
@property (strong, nonatomic) UIButton* gitButton;
@property (strong, nonatomic) CircleView* circle;
@property (strong, nonatomic) RectangleView* rectangle;
@property (strong, nonatomic) TriangleView* triangle;
@property (strong, nonatomic) DivideLineView* firstLine;
@property (strong, nonatomic) DivideLineView* secondLine;
@property (strong, nonatomic) NSArray* portraitConstraints;
@property (strong, nonatomic) NSArray* landscapeConstraints;


@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"RSSchool Task 6";
    [self customizeInfoLabels];
    [self customizeInfoStackView];
    [self customizeFiguresStackView];
    [self customizeButtons];
    [self customizeButtonsStackView];
    [self customizeDivideLines];
    [self setupConstraints];
}

//MARK: - Customize Views

- (void) customizeInfoLabels {
    self.appleImageView = [[UIImageView alloc] init];
    self.appleImageView.image = [UIImage imageNamed:@"apple"];
    self.appleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.appleImageView];
    
    self.nameDeviceLabel = [[UILabel alloc] init];
    self.nameDeviceLabel.backgroundColor = [UIColor clearColor];
    self.nameDeviceLabel.text = [[UIDevice currentDevice] name];
    self.nameDeviceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.modelDeviceLabel = [[UILabel alloc] init];
    self.modelDeviceLabel.backgroundColor = [UIColor clearColor];
    self.modelDeviceLabel.text = [[UIDevice currentDevice] model];
    self.modelDeviceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.versionIosLabel = [[UILabel alloc] init];
    self.versionIosLabel.backgroundColor = [UIColor clearColor];
    self.versionIosLabel.text = [NSString stringWithFormat: @"iOS %@", [[UIDevice currentDevice] systemVersion]];
    self.versionIosLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void) customizeInfoStackView {
    self.infoStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.nameDeviceLabel,
                                                                         self.modelDeviceLabel,
                                                                         self.versionIosLabel]];
    self.infoStackView.axis = UILayoutConstraintAxisVertical;
    self.infoStackView.alignment = UIStackViewAlignmentLeading;
    self.infoStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.infoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.infoStackView];
}

- (void) customizeDivideLines {
    self.firstLine = [[DivideLineView alloc] init];
    self.firstLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.firstLine];
    
    self.secondLine = [[DivideLineView alloc] init];
    self.secondLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.secondLine];
}

- (void) customizeFiguresStackView {
    self.circle = [[CircleView alloc] init];
    self.circle.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.rectangle = [[RectangleView alloc] init];
    self.rectangle.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.triangle = [[TriangleView alloc] init];
    self.triangle.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.figuresStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.circle,
                                                                            self.rectangle,
                                                                            self.triangle]];
    self.figuresStackView.axis = UILayoutConstraintAxisHorizontal;
    self.figuresStackView.alignment = UIStackViewAlignmentCenter;
    self.figuresStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.figuresStackView.layoutMargins = UIEdgeInsetsMake(0, 50, 0, 50);
    [self.figuresStackView setLayoutMarginsRelativeArrangement:YES];
    self.figuresStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.figuresStackView];
}

- (void) customizeButtons {
    self.goToStartButton = [[UIButton alloc] init];
    self.goToStartButton.backgroundColor = [UIColor hex:@"0xF9CC78"];
    self.goToStartButton.layer.cornerRadius = 27.5;
    self.goToStartButton.clipsToBounds = YES;
    [self.goToStartButton setTitle:@"Go to start!" forState:UIControlStateNormal];
    [self.goToStartButton setTitleColor:[UIColor hex:@"0x101010"] forState:UIControlStateNormal];
    [self.goToStartButton.titleLabel setFont:[UIFont systemFontOfSize:20.0 weight:UIFontWeightBold]];
    [self.goToStartButton addTarget:self action:@selector(goToStartVC) forControlEvents:UIControlEventTouchUpInside];
    self.goToStartButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.gitButton = [[UIButton alloc] init];
    self.gitButton.backgroundColor = [UIColor hex:@"0xEE686A"];
    self.gitButton.layer.cornerRadius = 27.5;
    self.gitButton.clipsToBounds = YES;
    [self.gitButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
    [self.gitButton setTitleColor:[UIColor hex:@"0xFFFFFF"] forState:UIControlStateNormal];
    [self.gitButton.titleLabel setFont:[UIFont systemFontOfSize:20.0 weight:UIFontWeightBold]];
    [self.gitButton addTarget:self action:@selector(goToGithub) forControlEvents:UIControlEventTouchUpInside];
    self.gitButton.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void) customizeButtonsStackView {
    BOOL orientationIsPortrait = [self getCurrentOrientation];
    
    self.buttonsStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.goToStartButton, self.gitButton]];
    self.buttonsStackView.axis = (orientationIsPortrait ? UILayoutConstraintAxisVertical : UILayoutConstraintAxisHorizontal);
    self.buttonsStackView.alignment = UIStackViewAlignmentCenter;
    self.buttonsStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.buttonsStackView.layoutMargins = UIEdgeInsetsMake(10, 0, 10, 0);
    [self.buttonsStackView setLayoutMarginsRelativeArrangement:YES];
    self.buttonsStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.buttonsStackView];
}

//MARK: - Setup Constraints

- (void) setupConstraints {
    self.portraitConstraints = @[
    [self.appleImageView.heightAnchor constraintEqualToConstant:100],
    [self.appleImageView.widthAnchor constraintEqualToConstant:100],
    [self.appleImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:40],
    [self.appleImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-80],
    [self.infoStackView.heightAnchor constraintEqualToConstant:80],
    [self.infoStackView.widthAnchor constraintEqualToConstant:200],
    [self.infoStackView.centerYAnchor constraintEqualToAnchor:self.appleImageView.centerYAnchor constant:5],
    [self.infoStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:100],
    [self.nameDeviceLabel.heightAnchor constraintEqualToConstant:20],
    [self.nameDeviceLabel.widthAnchor constraintEqualToConstant:150],
    [self.modelDeviceLabel.heightAnchor constraintEqualToConstant:20],
    [self.modelDeviceLabel.widthAnchor constraintEqualToConstant:150],
    [self.versionIosLabel.heightAnchor constraintEqualToConstant:20],
    [self.versionIosLabel.widthAnchor constraintEqualToConstant:150],
    [self.firstLine.heightAnchor constraintEqualToConstant:2],
    [self.firstLine.widthAnchor constraintEqualToConstant:300],
    [self.firstLine.topAnchor constraintEqualToAnchor:self.appleImageView.bottomAnchor constant:40],
    [self.firstLine.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [self.circle.heightAnchor constraintEqualToConstant:70],
    [self.circle.widthAnchor constraintEqualToConstant:70],
    [self.rectangle.heightAnchor constraintEqualToConstant:70],
    [self.rectangle.widthAnchor constraintEqualToConstant:70],
    [self.triangle.heightAnchor constraintEqualToConstant:70],
    [self.triangle.widthAnchor constraintEqualToConstant:70],
    [self.figuresStackView.heightAnchor constraintEqualToConstant:150],
    [self.figuresStackView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
    [self.figuresStackView.topAnchor constraintEqualToAnchor:self.firstLine.bottomAnchor constant:20],
    [self.figuresStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [self.secondLine.heightAnchor constraintEqualToConstant:2],
    [self.secondLine.widthAnchor constraintEqualToConstant:300],
    [self.secondLine.topAnchor constraintEqualToAnchor:self.figuresStackView.bottomAnchor constant:20],
    [self.secondLine.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [self.goToStartButton.heightAnchor constraintEqualToConstant:55],
    [self.goToStartButton.widthAnchor constraintEqualToConstant:300],
    [self.gitButton.heightAnchor constraintEqualToConstant:55],
    [self.gitButton.widthAnchor constraintEqualToConstant:300],
    [self.buttonsStackView.heightAnchor constraintEqualToConstant:150],
    [self.buttonsStackView.widthAnchor constraintEqualToConstant:300],
    [self.buttonsStackView.topAnchor constraintEqualToAnchor:self.secondLine.bottomAnchor constant:40],
    [self.buttonsStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ];
    
    self.landscapeConstraints = @[
    [self.appleImageView.heightAnchor constraintEqualToConstant:80],
    [self.appleImageView.widthAnchor constraintEqualToConstant:80],
    [self.appleImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
    [self.appleImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-80],
    [self.infoStackView.heightAnchor constraintEqualToConstant:75],
    [self.infoStackView.widthAnchor constraintEqualToConstant:200],
    [self.infoStackView.centerYAnchor constraintEqualToAnchor:self.appleImageView.centerYAnchor constant:5],
    [self.infoStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:100],
    [self.nameDeviceLabel.heightAnchor constraintEqualToConstant:20],
    [self.nameDeviceLabel.widthAnchor constraintEqualToConstant:150],
    [self.modelDeviceLabel.heightAnchor constraintEqualToConstant:20],
    [self.modelDeviceLabel.widthAnchor constraintEqualToConstant:150],
    [self.versionIosLabel.heightAnchor constraintEqualToConstant:20],
    [self.versionIosLabel.widthAnchor constraintEqualToConstant:150],
    [self.firstLine.heightAnchor constraintEqualToConstant:2],
    [self.firstLine.widthAnchor constraintEqualToConstant:500],
    [self.firstLine.topAnchor constraintEqualToAnchor:self.appleImageView.bottomAnchor constant:15],
    [self.firstLine.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [self.circle.heightAnchor constraintEqualToConstant:70],
    [self.circle.widthAnchor constraintEqualToConstant:70],
    [self.rectangle.heightAnchor constraintEqualToConstant:70],
    [self.rectangle.widthAnchor constraintEqualToConstant:70],
    [self.triangle.heightAnchor constraintEqualToConstant:70],
    [self.triangle.widthAnchor constraintEqualToConstant:70],
    [self.figuresStackView.heightAnchor constraintEqualToConstant:80],
    [self.figuresStackView.widthAnchor constraintEqualToConstant:400],
    [self.figuresStackView.topAnchor constraintEqualToAnchor:self.firstLine.bottomAnchor constant:15],
    [self.figuresStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [self.secondLine.heightAnchor constraintEqualToConstant:2],
    [self.secondLine.widthAnchor constraintEqualToConstant:500],
    [self.secondLine.topAnchor constraintEqualToAnchor:self.figuresStackView.bottomAnchor constant:5],
    [self.secondLine.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [self.goToStartButton.heightAnchor constraintEqualToConstant:55],
    [self.goToStartButton.widthAnchor constraintEqualToConstant:170],
    [self.gitButton.heightAnchor constraintEqualToConstant:55],
    [self.gitButton.widthAnchor constraintEqualToConstant:170],
    [self.buttonsStackView.heightAnchor constraintEqualToConstant:100],
    [self.buttonsStackView.widthAnchor constraintEqualToConstant:380],
    [self.buttonsStackView.topAnchor constraintEqualToAnchor:self.secondLine.bottomAnchor constant:5],
    [self.buttonsStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ];
    
    UIInterfaceOrientation orientationIsPortrait = [self getCurrentOrientation];
    if (orientationIsPortrait) {
        [NSLayoutConstraint activateConstraints:self.portraitConstraints];
    } else {
        [NSLayoutConstraint activateConstraints:self.landscapeConstraints];
    }
}

//MARK: - Helpers

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (size.height < size.width) {
        self.buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
        [NSLayoutConstraint deactivateConstraints:self.portraitConstraints];
        [NSLayoutConstraint activateConstraints:self.landscapeConstraints];
    } else if (size.height >= size.width) {
        self.buttonsStackView.axis = UILayoutConstraintAxisVertical;
        [NSLayoutConstraint deactivateConstraints:self.landscapeConstraints];
        [NSLayoutConstraint activateConstraints:self.portraitConstraints];
    }
}

- (BOOL) getCurrentOrientation {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        return  YES;
    }
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//MARK: - Actions

- (void) goToStartVC {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

- (void) goToGithub {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://github.com/kill-me-baby/rsschool-cv/blob/gh-pages/cv.md"] options:@{} completionHandler:nil];
}

@end
