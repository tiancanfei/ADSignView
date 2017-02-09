//
//  ADSignView.h
//  ADSignViewDemo
//
//  Created by andehang on 2017/2/9.
//  Copyright © 2017年 andehang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSignView : UIView

- (void)erase;

/**
 保存签名
 image:原图
 imageData:原图的NSData文件
 */
- (void)saveSign:(void(^)(UIImage *image,NSData *imageData))saveImageBlock;

@end
