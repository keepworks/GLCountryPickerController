//
//  EMCCountryCell.m
//  EMCCountryPickerController
//
//  Created by walker on 2018/9/17.
//  Copyright © 2018年 Enrico. All rights reserved.
//

#import "EMCCountryCell.h"
#import "EMCCountry.h"
@interface EMCCountryCell ()

/** icon */
@property (strong, nonatomic) UIImageView *countryImgView;

/** country title */
@property (strong, nonatomic) UILabel *countryLabel;

/** code label */
@property (strong, nonatomic) UILabel *codeLabel;

/** 国家模型 */
@property (strong, nonatomic) EMCCountry *country;

/** 时区 */
@property (strong, nonatomic) NSLocale *displayLocale;
@end

@implementation EMCCountryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_initialize];
        
        [self p_setUpUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)p_initialize {
}

- (void)p_setUpUI {
    
    [self.contentView addSubview:self.countryImgView];
    [self.contentView addSubview:self.countryLabel];
    [self.contentView addSubview:self.codeLabel];
    
    [self p_layoutWithMasonry];
}

- (void)p_layoutWithMasonry {
    
    self.countryImgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countryImgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.0f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countryImgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f]];
    [self.countryImgView addConstraint:[NSLayoutConstraint constraintWithItem:self.countryImgView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:32.0f]];
    [self.countryImgView addConstraint:[NSLayoutConstraint constraintWithItem:self.countryImgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:24.0f]];

    self.countryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countryLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.countryImgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.0f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countryLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.countryImgView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f]];
    
    self.codeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.codeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:- 10.0f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.codeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0f]];
    
}

- (void)updateDataWithModel:(EMCCountry *)country displayLocale:(NSLocale *)locale {
    
    if (country) {
        self.country = country;
        NSString *imagePath = [NSString stringWithFormat:@"EMCCountryPickerController.bundle/%@", self.country.countryCode];
        UIImage *image = [UIImage imageNamed:imagePath inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
        self.countryImgView.image = image;
        if (locale) {
            self.displayLocale = locale;
        }else {
            self.displayLocale = [NSLocale currentLocale];
        }
        
        self.countryLabel.text =  [self.country countryNameWithLocale:self.displayLocale];
        
        self.codeLabel.text = [self.country dialingCode];
    }
}
#pragma mark - 懒加载 --

- (UIImageView *)countryImgView {
    if (!_countryImgView) {
        _countryImgView = [[UIImageView alloc] init];
        _countryImgView.contentMode = UIViewContentModeScaleAspectFit;
        _countryImgView.layer.masksToBounds = NO;
    }
    return _countryImgView;
}

- (UILabel *)countryLabel {
    if(!_countryLabel) {
        _countryLabel = [[UILabel alloc] init];
        _countryLabel.textColor = [UIColor blackColor];
        _countryLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _countryLabel;
}

- (UILabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] init];
        _codeLabel.textColor = [UIColor blackColor];;
        _codeLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _codeLabel;
}

@end
