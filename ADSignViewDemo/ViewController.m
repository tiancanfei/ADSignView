//
//  ViewController.m
//  ADSignViewDemo
//
//  Created by andehang on 2016/10/28.
//  Copyright © 2016年 andehang. All rights reserved.
//

#import "ViewController.h"
#import "JLBSignView.h"

@interface ViewController ()

/**写字板*/
@property (nonatomic, strong) JLBSignView *signView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.signView = [[JLBSignView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [self.view addSubview:self.signView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
