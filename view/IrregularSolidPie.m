//
//  THPieView.m
//  HeadManage
//
//  Created by a111 on 17/9/6.
//  Copyright © 2017年 Tenghu. All rights reserved.
//

#import "IrregularSolidPie.h"

#define kAnimationDuration 1.0f
#define kPieBackgroundColor [UIColor clearColor]
#define kPieFillColor [UIColor clearColor].CGColor
#define kPieRandColor [UIColor colorWithRed:arc4random() % 255 / 255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.0f]
#define kLabelLoctionRatio (1.2*bgRadius)

@interface IrregularSolidPie()


@property (nonatomic ,assign) CGFloat total;
@property (nonatomic ,strong) CAShapeLayer *bgCircleLayer;

@end

@implementation IrregularSolidPie

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.hidden = YES;
        self.backgroundColor = kPieBackgroundColor;
        
    }
    return self;
}

#pragma mark - Private
-(void)setDataItems:(NSArray *)dataItems{
    _dataItems = dataItems;
}

-(void)setColorItems:(NSArray *)colorItems{
    _colorItems = colorItems;
}


- (void)stroke{

    //1.pieView中心点
    CGFloat centerWidth = self.frame.size.width * 0.5f;
    CGFloat centerHeight = self.frame.size.height * 0.5f;
    CGFloat centerX = centerWidth;
    CGFloat centerY = centerHeight;
    CGPoint centerPoint = CGPointMake(centerX, centerY);
    CGFloat radiusBasic = centerWidth > centerHeight ? centerHeight : centerWidth;
    
    //计算红绿蓝部分总和
    _total = 0.0f;
    for (int i = 0; i < _dataItems.count; i++) {
        _total += [_dataItems[i] floatValue];
    }
    
    //线的半径为扇形半径的一半，线宽是扇形半径，这样就能画出圆形了
    //2.背景路径
    CGFloat bgRadius = radiusBasic * 0.5+20;
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                          radius:bgRadius
                                                      startAngle:-M_PI_2 *3
                                                        endAngle:M_PI_2
                                                       clockwise:YES];
    _bgCircleLayer = [CAShapeLayer layer];
    _bgCircleLayer.fillColor   = [UIColor clearColor].CGColor;
    _bgCircleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    _bgCircleLayer.strokeStart = 0.0f;
    _bgCircleLayer.strokeEnd   = 1.0f;
    _bgCircleLayer.zPosition   = 1;
    _bgCircleLayer.lineWidth   = bgRadius * 2.0f;
    _bgCircleLayer.path        = bgPath.CGPath;
    
    
    //3.子扇区路径
    
    CGFloat start = 0.0f;
    CGFloat end = 0.0f;
    for (int i = 0; i < _dataItems.count; i++) {
        //4.计算当前end位置 = 上一个结束位置 + 当前部分百分比
        end = [_dataItems[i] floatValue] / _total + start;
        
        CGFloat otherRadius = radiusBasic * 0.5 - 3.0+20 - i*5;
        
        UIBezierPath *otherPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                                 radius:otherRadius
                                                             startAngle:-M_PI_2*3
                                                               endAngle:M_PI_2
                                                              clockwise:YES];
        //图层
        CAShapeLayer *pie = [CAShapeLayer layer];
        [self.layer addSublayer:pie];
        pie.fillColor   = kPieFillColor;
        if (i > _colorItems.count - 1 || !_colorItems  || _colorItems.count == 0) {//如果传过来的颜色数组少于item个数则随机填充颜色
            pie.strokeColor = kPieRandColor.CGColor;
        } else {
            pie.strokeColor = ((UIColor *)_colorItems[i]).CGColor;
        }
        pie.strokeStart = start;
        pie.strokeEnd   = end;
        pie.lineWidth   = otherRadius * 2 ;
        pie.zPosition   = 2;
        pie.path        = otherPath.CGPath;
        
        NSString *time = _dataItems[i];
        
        //计算百分比label的位置
        CGFloat centerAngle = M_PI * (start + end);
        CGFloat labelCenterX = -((otherRadius+3.0)*1.2) * sinf(centerAngle) + centerX;
        CGFloat labelCenterY = ((otherRadius+3.0)*1.2) * cosf(centerAngle) + centerY;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, radiusBasic * 0.7f, radiusBasic * 0.7f)];
        label.center = CGPointMake(labelCenterX, labelCenterY);
        //  label.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)((end - start + 0.005) * 100)];
        label.font = [UIFont systemFontOfSize:9];
        label.text = time;
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines =2;
        label.layer.zPosition = 3;
        [self addSubview:label];
        
        
        //计算下一个start位置 = 当前end位置
        start = end;
    }
    
    
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    cView.backgroundColor = [UIColor whiteColor];
    cView.center = centerPoint;
    cView.layer.borderColor = [UIColor yellowColor].CGColor;
    cView.layer.borderWidth = 3;
    cView.layer.zPosition = 4;
    cView.layer.masksToBounds = YES;
    cView.layer.cornerRadius = 30;
    [self addSubview:cView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 60,20)];
            label.font = [UIFont systemFontOfSize:11];
    label.text = @"11h";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blueColor];
    label.layer.zPosition = 4;
    [cView addSubview:label];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 60, 20)];
    label2.font = [UIFont systemFontOfSize:9];
    label2.text = @"总时长";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor colorWithWhite:0 alpha:0.8];
    label2.layer.zPosition = 4;
    [cView addSubview:label2];
    
    self.layer.mask = _bgCircleLayer;
    
    [self show];
        

}
- (void)show
{
    //画图动画
    self.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration  = kAnimationDuration;
    animation.fromValue = @0.0f;
    animation.toValue   = @1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    [_bgCircleLayer addAnimation:animation forKey:@"circleAnimation"];
    
}
- (void)dealloc
{
    [self.layer removeAllAnimations];
}


@end
