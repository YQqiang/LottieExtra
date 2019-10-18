//
//  TestOCViewController.m
//  LottieExtra_Example
//
//  Created by sungrow on 2019/6/12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#import "TestOCViewController.h"
#import <LottieExtra/LottieExtra-Swift.h>
#import <Lottie/Lottie-Swift.h>

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lottieView];
    self.lottieView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.lottieView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:32].active = YES;
    [self.lottieView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16].active = YES;
    [self.lottieView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16].active = YES;
    [self.lottieView.heightAnchor constraintEqualToConstant:200].active = YES;
    
    [self.lottieView configAnimationWithName:@"micro_dot" bundle:[NSBundle mainBundle]];
    [self.lottieView play];
    self.lottieView.loopMode = LottieExtraLoopModeAutoReverse;
    
    /// Test show/hidden keyPath
    [self.lottieView hiddenWithKeyPath:@""];
    [self.lottieView hiddenWithKeyPath:@".energyBatterytoLoad"];
    [self.lottieView hiddenWithKeyPath:@".energyBatterytoGrid"];
    [self.lottieView hiddenWithKeyPath:@".energyGridtoBattery"];
    [self.lottieView hiddenWithKeyPath:@".energyGridtoLoad"];
    
    [self.lottieView hiddenWithKeyPath:@".energyInvertertoLoad"];
    [self.lottieView hiddenWithKeyPath:@".energyInvertertoGrid"];
    [self.lottieView hiddenWithKeyPath:@".energyInvertertoBattery"];
    
    [self.lottieView hiddenWithKeyPath:@".ButtonGrid"];
    [self.lottieView showWithKeyPath:@"**"];
    [self.lottieView showWithKeyPath:@".energyInvertertoLoad"];
    
    ///  Test action
    [self.lottieView addTargetWithTarget:self action:@selector(gridAction) keyPath:@".ButtonGrid"];
    [self.lottieView addTargetWithTarget:self action:@selector(invertAction:) keyPath:@".ButtonInverter"];
    [self.lottieView removeTargetWithAction:@selector(gridAction) keyPath:@".ButtonGrid"];
    
    /// Test add View
    UILabel *lbl = [[UILabel alloc] init];
    lbl.textColor = UIColor.blackColor;
    lbl.text = @"测试文字,,, Test label";
    lbl.backgroundColor = UIColor.redColor;
    lbl.font = [UIFont systemFontOfSize:18];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.frame = CGRectMake(0, 0, 300, 44);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        lbl.text = @"文本内容发生了改变,  Test label";
    });
    [self.lottieView addView:lbl keyPath:@".TextInverter"];
    
    UILabel *lbl2 = [[UILabel alloc] init];
    lbl2.textColor = UIColor.orangeColor;
    lbl2.text = @"电网文本";
    lbl2.backgroundColor = UIColor.blueColor;
    lbl2.font = [UIFont systemFontOfSize:18];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.frame = CGRectMake(0, 0, 200, 44);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        lbl2.text = @"电网 文本 发生了变化";
    });
    [self.lottieView addView:lbl2 keyPath:@".TextGrid"];
    
    /// Test view center
    CGPoint position = [self.lottieView.animationView viewCenterFor:@".TextPCS"];
    UIView *viewP = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    viewP.backgroundColor = UIColor.orangeColor;
    viewP.center = position;
    [self.lottieView addSubview:viewP];
}

- (void)gridAction {
    NSLog(@"%s", __func__);
}

- (void)invertAction:(LottieExtraAction *)sender {
    NSLog(@"%s", __func__);
    NSLog(@"%@", sender.keyPath);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        TestOCViewController *testVC = [[TestOCViewController alloc] init];
        [self presentViewController:testVC animated:YES completion:nil];
    }
}

@end
