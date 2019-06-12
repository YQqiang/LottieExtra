//
//  TestOCViewController.m
//  LottieExtra_Example
//
//  Created by sungrow on 2019/6/12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#import "TestOCViewController.h"
#import <LottieExtra/LottieExtra-Swift.h>

@interface TestOCViewController ()

@property (nonatomic, strong) LottieExtraView *lottieView;

@end

@implementation TestOCViewController

- (LottieExtraView *)lottieView {
    if (!_lottieView) {
        _lottieView = [[LottieExtraView alloc] init];
    }
    return _lottieView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.lottieView];
    self.lottieView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.lottieView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:32].active = YES;
    [self.lottieView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16].active = YES;
    [self.lottieView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16].active = YES;
    [self.lottieView.heightAnchor constraintEqualToConstant:200].active = YES;
    
    [self.lottieView configAnimationWithName:@"micro" bundle:[NSBundle mainBundle]];
    [self.lottieView play];
//    lottieView.animationView.loopMode = .loop
    
    /// Test show/hidden keyPath
    [self.lottieView hiddenWithKeyPath:@""];
    [self.lottieView hiddenWithKeyPath:@"能量_电池to用电"];
    [self.lottieView hiddenWithKeyPath:@"能量_电池to电网"];
    [self.lottieView hiddenWithKeyPath:@"能量_电网to电池"];
    [self.lottieView hiddenWithKeyPath:@"能量_电网to用电"];
    
    [self.lottieView hiddenWithKeyPath:@"能量_逆变器to用电"];
    [self.lottieView hiddenWithKeyPath:@"能量_逆变器to电网"];
    [self.lottieView hiddenWithKeyPath:@"能量_逆变器to电池"];
    
    [self.lottieView hiddenWithKeyPath:@"按钮_电网"];
    [self.lottieView showWithKeyPath:@"**"];
    [self.lottieView showWithKeyPath:@"能量_逆变器to用电"];
    
    ///  Test action
    [self.lottieView addTargetWithTarget:self action:@selector(gridAction) keyPath:@"按钮_电网"];
    [self.lottieView addTargetWithTarget:self action:@selector(invertAction:) keyPath:@"按钮_逆变器"];
    [self.lottieView removeTargetWithAction:@selector(gridAction) keyPath:@"按钮_电网"];
}

- (void)gridAction {
    NSLog(@"%s", __func__);
}

- (void)invertAction:(LottieExtraView *)sender {
    NSLog(@"%s", __func__);
    NSLog(@"%@", sender);
}


@end
