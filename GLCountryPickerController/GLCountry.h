//
//  GLCountry.h
//  GLCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface GLCountry : NSObject

@property (readonly) NSString *countryCode;

+ (instancetype)countryWithCountryCode:(NSString *)code;
- (instancetype)initWithCountryCode:(NSString *)code;
/* 国家名称 */
- (NSString *)name;
/* 电话国家区号 */
- (NSString *)dialingCode;
/* 对国家名称进行国际化 */
- (NSString *)countryNameWithLocale:(NSLocale *)locale;
/* 根据传入的本地化标识对国家名称进行h国际化 */
- (NSString *)countryNameWithLocaleIdentifier:(NSString *)localeIdentifier;
/* 国旗对象 */
- (UIImage * _Nullable)nationalFlag;
@end
NS_ASSUME_NONNULL_END
