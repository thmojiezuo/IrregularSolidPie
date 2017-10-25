//
//  ViewController.m
//  IrregularSolidPie
//
//  Created by tenghu on 2017/10/25.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "ViewController.h"
#import "IrregularSolidPie.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define RGB(r,g,b)[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

@interface ViewController ()

@property (nonatomic ,strong)IrregularSolidPie *pie;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *timearr = @[@"210",@"183",@"165",@"150",@"110"];
    NSArray *colorArr = @[RGB(243, 47, 105),RGB(250, 185, 79),RGB(96, 233, 26),RGB(69, 192, 254),RGB(63, 96, 241)];
    _pie = [[IrregularSolidPie alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2 , 100, 200, 200)];
    _pie.dataItems = timearr;
    _pie.colorItems = colorArr;
    [self.view addSubview:_pie];
    [_pie stroke];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
