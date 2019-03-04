//
//  DemoController.m
//  EMCCountryPickerControllerDemo
//
//  Created by 幽雅的暴君 on 2019/3/1.
//  Copyright © 2019 Enrico M. Crisostomo. All rights reserved.
//

#import "DemoController.h"
#import "EMCCountryPicker.h"
@interface DemoController () <EMCCountryDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *countryIconView;
@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryDialingCodesLabel;

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}

- (IBAction)p_showCountryPickerController:(UIButton *)sender {
    
    EMCCountryPickerController *pickerVC = [[EMCCountryPickerController alloc] initWithAvailableCountryCodes:nil];
    pickerVC.countryDelegate = self;
    
    [self.navigationController pushViewController:pickerVC animated:YES];
}

#pragma mark - 代理方法 --

- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry {
    
    if (chosenCountry) {
        
        NSString *name = [chosenCountry countryNameWithLocale:[NSLocale currentLocale]];
        
        self.countryIconView.image = [chosenCountry nationalFlag];
        
        self.countryNameLabel.text = [NSString stringWithFormat:@"name:%@",name];
        
        self.countryDialingCodesLabel.text = [NSString stringWithFormat:@"DialingCodes:%@",chosenCountry.dialingCode];
    }
}

@end
