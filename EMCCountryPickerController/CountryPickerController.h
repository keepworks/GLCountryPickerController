//
//  CountryPickerController.h
//  EMCCountryPickerController
//
//  Created by walker on 2018/9/17.
//  Copyright © 2018年 Enrico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMCCountryDelegate.h"

@interface CountryPickerController : UIViewController

/** 国家名称展示的语言时区 */
@property (strong, nonatomic) NSLocale *countryNameDisplayLocale;

/* 搜索控制器 */
@property (readonly, strong, nonatomic) UISearchController *searchController;

/** 代理 */
@property (weak, nonatomic) id<EMCCountryDelegate> countryDelegate;

/**
 初始化

 @param availableCountryCodes 当前可以展示的国家代码
 */
- (instancetype)initWithAvailableCountryCodes:(NSSet *)availableCountryCodes;

@end
