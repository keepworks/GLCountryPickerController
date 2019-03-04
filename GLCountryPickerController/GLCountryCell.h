//
//  GLCountryCell.h
//  GLCountryPickerController
//
//  Created by walker on 2018/9/17.
//  Copyright © 2018年 Enrico. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLCountry;
@interface GLCountryCell : UITableViewCell

/**
 更新数据

 @param country 国家信息
 */
- (void)updateDataWithModel:(GLCountry *)country displayLocale:(NSLocale *)locale;
@end
