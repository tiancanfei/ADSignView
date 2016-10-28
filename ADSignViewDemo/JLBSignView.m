//
//  JLBSignView.m
//  SmartCampusSever
//
//  Created by andehang on 2016/10/28.
//  Copyright © 2016年 jinlinbao. All rights reserved.
//

#import "JLBSignView.h"

@interface JLBSignView()

/**路径集合*/
@property (nonatomic, strong)  NSMutableArray *paths;

/**当前路径*/
@property (nonatomic, strong) UIBezierPath *currentPath;

/**上一点*/
@property (nonatomic, assign)  CGPoint previousPoint;

@end

@implementation JLBSignView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
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
    
//    self.currentPath.lineWidth = 5.0;
//    
//    UIColor *color = [UIColor redColor];
//    [color set]; //设置线条颜色
//    
//    self.currentPath.lineCapStyle = kCGLineCapSquare; //线条拐角
//    self.currentPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    [self.currentPath stroke];
//    
//    
    [self.paths enumerateObjectsUsingBlock:^(UIBezierPath *currentPath, NSUInteger idx, BOOL * _Nonnull stop) {
        currentPath.lineWidth = 5.0;
        
        UIColor *color = [UIColor redColor];
        [color set]; //设置线条颜色
        
        currentPath.lineCapStyle = kCGLineCapSquare; //线条拐角
        currentPath.lineJoinStyle = kCGLineCapRound; //终点处理
        
        [currentPath stroke];
    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = touches.anyObject;
//    CGPoint point = [touch locationInView:self];
//    self.previousPoint = point;
//    self.currentPath = [UIBezierPath bezierPath];
//    [self.currentPath moveToPoint:point];
//}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = touches.anyObject;
//    CGPoint point = [touch locationInView:self];
//    CGPoint midPoint = midpoint(self.previousPoint, point);
////    [self.currentPath addLineToPoint:point];
////    [self.paths addObject:self.currentPath];
//    [self.currentPath addQuadCurveToPoint:midPoint controlPoint:self.previousPoint];
//    [self.paths addObject:self.currentPath];
//    [self setNeedsDisplay];
//}



- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self];
    CGPoint midPoint = midpoint(self.previousPoint, currentPoint);
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.currentPath = [UIBezierPath bezierPath];
        [self.currentPath moveToPoint:currentPoint];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.currentPath addQuadCurveToPoint:midPoint controlPoint:self.previousPoint];
        [self.paths addObject:self.currentPath];
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

@end
