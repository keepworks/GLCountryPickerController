//
//  ViewController.m
//  GLCountryPickerControllerDemo
//
//  Created by 幽雅的暴君 on 2019/3/4.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ViewController.h"
#import "GLCountryPicker.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *countryIconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dialingCodesLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)selectedCountryBtnAction:(UIButton *)sender {
    
    GLCountryPickerController *pickerVC = [[GLCountryPickerController alloc] initWithAvailableCountryCodes:nil];
    pickerVC.countryDelegate = self;
    
    [self.navigationController pushViewController:pickerVC animated:YES];
}


#pragma mark - 代理方法 --

- (void)countryController:(id)sender didSelectCountry:(GLCountry *)chosenCountry {
    
    if (chosenCountry) {
        
        NSString *name = [chosenCountry countryNameWithLocale:[NSLocale currentLocale]];
        
        self.countryIconView.image = [chosenCountry nationalFlag];
        
        self.nameLabel.text = [NSString stringWithFormat:@"name:%@",name];
        
        self.dialingCodesLabel.text = [NSString stringWithFormat:@"DialingCodes:%@",chosenCountry.dialingCode];
    }
}
@end
