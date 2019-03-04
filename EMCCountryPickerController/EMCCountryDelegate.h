//
//  EMCCountryDelegate.h
//  EMCCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 19/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EMCCountry;

@protocol EMCCountryDelegate <NSObject>

@required

/**
 点击的回调

 @param sender 选择国家的控制器
 @param chosenCountry 选择的国家
 */
- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry;

@end
