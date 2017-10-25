//
//  THPieView.h
//  HeadManage
//
//  Created by a111 on 17/9/6.
//  Copyright © 2017年 Tenghu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IrregularSolidPie : UIView


@property (nonatomic ,strong)NSArray *dataItems;
@property (nonatomic ,strong)NSArray *colorItems;

- (void)stroke;



@end
