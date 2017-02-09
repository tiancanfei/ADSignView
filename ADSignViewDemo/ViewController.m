//
//  ViewController.m
//  ADSignViewDemo
//
//  Created by andehang on 2016/10/28.
//  Copyright © 2016年 andehang. All rights reserved.
//

#import "ViewController.h"
#import "ADSignView.h"
#import "ViewController1.h"

@interface ViewController ()

/**写字板*/
@property (nonatomic, strong) ADSignView *signView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];

    self.signView = [[ADSignView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
//    self.signView.backgroundColor = [UIColor clearColor];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width, 60)];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    
    [btn setTitle:@"保存" forState:UIControlStateHighlighted];
    
    [btn setTitle:@"保存" forState:UIControlStateDisabled];
    
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btn];
    
    [self.view addSubview:self.signView];
}

- (void)save
{
    __weak typeof(self) weakSelf = self;
    [self.signView saveSign:^(UIImage *image, NSData *imageData) {
        ViewController1 *v = [[ViewController1 alloc] init];
        v.image = image;
        [self presentViewController:v animated:YES completion:nil];

        [weakSelf saveLocationWithImage:image];
    }];
}

- (void)saveLocationWithImage:(UIImage *)image
{
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.png"];
    NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.jpg"];
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:jpgPath atomically:YES];
    
    // Write image to PNG
    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSLog(@"%@",paths);
    
    // Let's check to see if files were successfully written...
    
    // Create file manager
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // Point to Document directory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

     NSLog(@"%@",documentsDirectory);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
