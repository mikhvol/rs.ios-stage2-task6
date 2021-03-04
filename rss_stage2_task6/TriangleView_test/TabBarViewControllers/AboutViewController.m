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
@property (strong, nonatomic) UILabel* nameDeviceLabel;
@property (strong, nonatomic) UILabel* modelDeviceLabel;
@property (strong, nonatomic) UILabel* versionIosLabel;
@property (strong, nonatomic) UIStackView* figuresStackView;
@property (strong, nonatomic) UIStackView* buttonsStackView;
@property (strong, nonatomic) UIButton* goToStartButton;
@property (strong, nonatomic) UIButton* gitButton;

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
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) customizeFiguresStackView {
    CircleView* circle = [[CircleView alloc] init];
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    [circle.heightAnchor constraintEqualToConstant:70].active = YES;
    [circle.widthAnchor constraintEqualToConstant:70].active = YES;
    
    RectangleView* rectangle = [[RectangleView alloc] init];
    rectangle.translatesAutoresizingMaskIntoConstraints = NO;
    [rectangle.heightAnchor constraintEqualToConstant:70].active = YES;
    [rectangle.widthAnchor constraintEqualToConstant:70].active = YES;
    
    TriangleView* triangle = [[TriangleView alloc] init];
    triangle.translatesAutoresizingMaskIntoConstraints = NO;
    [triangle.heightAnchor constraintEqualToConstant:70].active = YES;
    [triangle.widthAnchor constraintEqualToConstant:70].active = YES;
    
    self.figuresStackView = [[UIStackView alloc] initWithArrangedSubviews:@[circle, rectangle, triangle]];
    self.figuresStackView.frame = CGRectMake(0, self.view.center.y * 0.75, self.view.frame.size.width, 150);
    self.figuresStackView.axis = UILayoutConstraintAxisHorizontal;
    self.figuresStackView.alignment = UIStackViewAlignmentCenter;
    self.figuresStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.figuresStackView.layoutMargins = UIEdgeInsetsMake(0, 50, 0, 50);
    [self.figuresStackView setLayoutMarginsRelativeArrangement:YES];
    [self.view addSubview:self.figuresStackView];
}

- (void) customizeButtonsStackView {
    self.buttonsStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.goToStartButton, self.gitButton]];
    self.buttonsStackView.frame = CGRectMake(0, self.view.center.y * 1.35, self.view.frame.size.width, 150);
    self.buttonsStackView.axis = UILayoutConstraintAxisVertical;
    self.buttonsStackView.alignment = UIStackViewAlignmentCenter;
    self.buttonsStackView.distribution = UIStackViewDistributionEqualSpacing;
    self.buttonsStackView.layoutMargins = UIEdgeInsetsMake(10, 0, 10, 0);
    [self.buttonsStackView setLayoutMarginsRelativeArrangement:YES];
    [self.view addSubview:self.buttonsStackView];
}

- (void) customizeButtons {
    self.goToStartButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.75, 55)];
    self.goToStartButton.backgroundColor = [UIColor hex:@"0xF9CC78"];
    self.goToStartButton.layer.cornerRadius = 27.5;
    self.goToStartButton.clipsToBounds = YES;
    [self.goToStartButton setTitle:@"Go to start!" forState:UIControlStateNormal];
    [self.goToStartButton setTitleColor:[UIColor hex:@"0x101010"] forState:UIControlStateNormal];
    [self.goToStartButton.titleLabel setFont:[UIFont systemFontOfSize:20.0 weight:UIFontWeightBold]];
    [self.goToStartButton.heightAnchor constraintEqualToConstant:55].active = YES;
    [self.goToStartButton.widthAnchor constraintEqualToConstant:self.view.frame.size.width * 0.75].active = YES;
    [self.goToStartButton addTarget:self action:@selector(goToStartVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.gitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.75, 55)];
    self.gitButton.backgroundColor = [UIColor hex:@"0xEE686A"];
    self.gitButton.layer.cornerRadius = 27.5;
    self.gitButton.clipsToBounds = YES;
    [self.gitButton setTitle:@"Open Git CV" forState:UIControlStateNormal];
    [self.gitButton setTitleColor:[UIColor hex:@"0xFFFFFF"] forState:UIControlStateNormal];
    [self.gitButton.titleLabel setFont:[UIFont systemFontOfSize:20.0 weight:UIFontWeightBold]];
    [self.gitButton.heightAnchor constraintEqualToConstant:55].active = YES;
    [self.gitButton.widthAnchor constraintEqualToConstant:self.view.frame.size.width * 0.75].active = YES;
    [self.gitButton addTarget:self action:@selector(goToGithub) forControlEvents:UIControlEventTouchUpInside];
}

- (void) customizeDivideLines {
    DivideLineView* firstLine = [[DivideLineView alloc] init];
    firstLine.frame = CGRectMake(40, self.figuresStackView.frame.origin.y - 25, self.goToStartButton.frame.size.width + 20, 2);
    [self.view addSubview:firstLine];
    
    DivideLineView* secondLine = [[DivideLineView alloc] init];
    secondLine.frame = CGRectMake(40, self.buttonsStackView.frame.origin.y - 25, self.goToStartButton.frame.size.width + 20, 2);
    [self.view addSubview:secondLine];
}

- (void) customizeInfoLabels {
    
    UIImageView* appleImageView = [[UIImageView alloc] init];
    appleImageView.frame = CGRectMake(40, 80, 100, 100);
    appleImageView.image = [UIImage imageNamed:@"apple"];
    appleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:appleImageView];
    
    self.nameDeviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    self.nameDeviceLabel.backgroundColor = [UIColor clearColor];
    self.nameDeviceLabel.text = [[UIDevice currentDevice] name];
    self.nameDeviceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nameDeviceLabel.heightAnchor constraintEqualToConstant:20].active = YES;
    [self.nameDeviceLabel.widthAnchor constraintEqualToConstant:100].active = YES;
    
    self.modelDeviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    self.modelDeviceLabel.backgroundColor = [UIColor clearColor];
    self.modelDeviceLabel.text = [[UIDevice currentDevice] model];
    self.modelDeviceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.modelDeviceLabel.heightAnchor constraintEqualToConstant:20].active = YES;
    [self.modelDeviceLabel.widthAnchor constraintEqualToConstant:100].active = YES;
    
    self.versionIosLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    self.versionIosLabel.backgroundColor = [UIColor clearColor];
    self.versionIosLabel.text = [NSString stringWithFormat: @"iOS %@", [[UIDevice currentDevice] systemVersion]];
    self.versionIosLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.versionIosLabel.heightAnchor constraintEqualToConstant:20].active = YES;
    [self.versionIosLabel.widthAnchor constraintEqualToConstant:100].active = YES;
}

- (void) customizeInfoStackView {
    self.infoStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.nameDeviceLabel, self.modelDeviceLabel, self.versionIosLabel]];
    self.infoStackView.frame = CGRectMake(self.view.center.x - 20, 95, 200, 80);
    self.infoStackView.axis = UILayoutConstraintAxisVertical;
    self.infoStackView.alignment = UIStackViewAlignmentLeading;
    self.infoStackView.distribution = UIStackViewDistributionEqualSpacing;
    [self.view addSubview:self.infoStackView];
}


//MARK: - Actions

- (void) goToStartVC {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

- (void) goToGithub {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://github.com/kill-me-baby/rsschool-cv/blob/gh-pages/cv.md"] options:@{} completionHandler:nil];
}



@end
