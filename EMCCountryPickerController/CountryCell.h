//
//  CountryCell.h
//  EMCCountryPickerController
//
//  Created by walker on 2018/9/17.
//  Copyright © 2018年 Enrico. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EMCCountry;
@interface CountryCell : UITableViewCell

/**
 更新数据

 @param country 国家信息
 */
- (void)updateDataWithModel:(EMCCountry *)country displayLocale:(NSLocale *)locale;
@end
