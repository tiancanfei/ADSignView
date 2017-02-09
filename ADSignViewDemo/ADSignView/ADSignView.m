//
//  ADSignView.m
//  ADSignViewDemo
//
//  Created by andehang on 2017/2/9.
//  Copyright © 2017年 andehang. All rights reserved.
//

#import "ADSignView.h"

@interface ADSignView()

/**路径集合*/
@property (nonatomic, strong)  NSMutableArray *paths;

/**当前路径*/
@property (nonatomic, strong) UIBezierPath *currentPath;

/**上一点*/
@property (nonatomic, assign)  CGPoint previousPoint;

@end

@implementation ADSignView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}



static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}



- (void)drawRect:(CGRect)rect
{
    [self.paths enumerateObjectsUsingBlock:^(UIBezierPath *currentPath, NSUInteger idx, BOOL * _Nonnull stop) {
        currentPath.lineWidth = 5.0;
        
        UIColor *color = [UIColor redColor];
        [color set]; //设置线条颜色
        
        currentPath.lineCapStyle = kCGLineCapRound; //线条拐角
        currentPath.lineJoinStyle = kCGLineCapRound; //终点处理
        
        [currentPath stroke];
    }];
}




- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self];
    CGPoint midPoint = midpoint(self.previousPoint, currentPoint);
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.currentPath = [UIBezierPath bezierPath];
        [self.currentPath moveToPoint:currentPoint];
        [self.paths addObject:self.currentPath];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.currentPath addQuadCurveToPoint:midPoint controlPoint:self.previousPoint];
    }
    
    self.previousPoint = currentPoint;
    
    [self setNeedsDisplay];
}



#pragma mark - setter getter

- (NSMutableArray *)paths
{
    if (!_paths)
    {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (void)erase
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)saveSign:(void(^)(UIImage *image,NSData *imageData))saveImageBlock
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *signImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //    NSData *signImageData = UIImageJPEGRepresentation(signImage, 1.0);
    
    //png格式
    NSData *signImageData = UIImagePNGRepresentation(signImage);
    
    if (saveImageBlock)
    {
        saveImageBlock(signImage,signImageData);
    }
}

@end
