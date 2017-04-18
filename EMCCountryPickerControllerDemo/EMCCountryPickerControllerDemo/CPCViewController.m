//
//  CPCViewController.m
//  EMCCountryPickerControllerDemo
//
//  Created by Enrico Maria Crisostomo on 23/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import "CPCViewController.h"
#import "EMCCountryPickerController.h"

@interface CPCViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *allCountriesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *smallFlagsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *dialingCodesSwitch;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dialingCodeLabel;

@end

@implementation CPCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCity
{
    self.countryLabel.text = chosenCity.name;
    self.codeLabel.text = chosenCity.countryCode;
    self.dialingCodeLabel.text = chosenCity.dialingCode;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openCountryPicker"])
    {
        EMCCountryPickerController *countryPicker = segue.destinationViewController;

        // default values
        countryPicker.showFlags = true;
        countryPicker.delegate = self;
        countryPicker.drawFlagBorder = true;
        countryPicker.flagBorderColor = [UIColor grayColor];
        countryPicker.flagBorderWidth = 0.5f;
        
        if ([self.smallFlagsSwitch isOn])
        {
            countryPicker.flagSize = 20;
        }
        
        if (![self.dialingCodesSwitch isOn])
        {
            countryPicker.showDialingCodes = NO;
        }
        
        if (![self.allCountriesSwitch isOn])
        {
            countryPicker.availableCountryCodes = [NSSet setWithObjects:@"IT", @"ES", @"US", @"FR", nil];
        }
    }
}

@end
