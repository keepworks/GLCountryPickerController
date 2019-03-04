//
//  GLCountryPickerController.m
//  GLCountryPickerController
//
//  Created by walker on 2018/9/17.
//  Copyright © 2018年 Enrico. All rights reserved.
//

#import "GLCountryPickerController.h"
#import "GLCountryManager.h"
#import "GLCountryCell.h"

@interface GLCountryPickerController ()<UITableViewDelegate, UITableViewDataSource,UISearchControllerDelegate, UISearchBarDelegate,UISearchResultsUpdating>

/** 列表 */
@property (strong, nonatomic) UITableView *listView;

/** 搜索框 */
@property (readwrite, strong, nonatomic) UISearchController *searchController;

/** 选中的国家 */
@property (strong, nonatomic) GLCountry *selectedCountry;

/** 总的国家列表 */
@property (strong, nonatomic) NSArray *countries;

/** 搜索结果 */
@property (strong, nonatomic) NSArray *countrySearchResults;

/** 搜索结果 */
@property (strong, nonatomic) NSMutableArray *countryData;

/** 需要显示的国家代码 */
@property (strong, nonatomic) NSSet *availableCountryCodes;

/** 搜索框的控制器 */
@property (strong, nonatomic) UISearchDisplayController *displayController;

@end


static NSString *const countryPicker_listView_cell_id_1 = @"countryPicker_listView_cell_id_1";
@implementation GLCountryPickerController

/**
 初始化
 
 @param availableCountryCodes 当前需要展示的国家代码
 */
- (instancetype)initWithAvailableCountryCodes:(NSSet *)availableCountryCodes {
    
    if (self = [super init]) {
        if (availableCountryCodes && availableCountryCodes.count > 0) {
            self.availableCountryCodes = [availableCountryCodes copy];
        }
        
        [self p_initialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self p_initialize];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self p_initialize];
    }
    
    return self;
}


- (void)p_initialize {

    self.countryData = @[].mutableCopy;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = self.searchController.searchBar;
    self.navigationController.navigationBar.translucent = NO;
    
    [self p_setUpUI];
}

- (void)p_setUpUI {
    
    [self.view addSubview:self.listView];
    
    self.listView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.listView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.listView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.listView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.listView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self p_loadCountries];
    [self.displayController setActive:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

    [self.searchController dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadCountrySelection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//set
-(void)setCountryData:(NSMutableArray *)countryData
{
    _countryData = countryData;
    [self.listView reloadData];
}
#pragma mark - Table View delegate Method-----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.countryData count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedCountry = [self.countryData objectAtIndex:indexPath.row];
    
    if (_countryDelegate && [_countryDelegate respondsToSelector:@selector(countryController:didSelectCountry:)]) {
        [_countryDelegate countryController:self didSelectCountry:self.selectedCountry];
    }
    
    __weak typeof(self)weakSelf;
    if (self.searchController.dimsBackgroundDuringPresentation) {
        [self.searchController dismissViewControllerAnimated:YES completion:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    else
    {
         [self.navigationController popViewControllerAnimated:YES];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:countryPicker_listView_cell_id_1 forIndexPath:indexPath];
    
    GLCountry *currentCountry;

    currentCountry = [self.countryData objectAtIndex:indexPath.row];
    
    [cell updateDataWithModel:currentCountry displayLocale:self.countryNameDisplayLocale];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

#pragma mark - 私有方法 --

- (void)p_loadCountries {
    
    NSArray *availableCountries;
    
    if (self.availableCountryCodes && self.availableCountryCodes.count > 0)
    {
        availableCountries = [self p_filterAvailableCountries:self.availableCountryCodes];
    }
    else
    {
        availableCountries = [[GLCountryManager countryManager] allCountries];
    }
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, nil];
    _countries = [availableCountries sortedArrayUsingDescriptors:descriptors];
    
    self.countryData = [NSMutableArray arrayWithArray:_countries];

}

- (NSArray *)p_filterAvailableCountries:(NSSet *)countryCodes
{
    GLCountryManager *countryManager = [GLCountryManager countryManager];
    NSMutableArray *countries = [[NSMutableArray alloc] initWithCapacity:[countryCodes count]];
    
    for (id code in self.availableCountryCodes)
    {
        if ([countryManager existsCountryWithCode:code])
        {
            [countries addObject:[countryManager countryWithCode:code]];
        }
        else
        {
            [NSException raise:@"Unknown country code" format:@"Unknown country code %@", code];
        }
    }
    
    return countries;
}

- (void)loadCountrySelection
{
    if (!_selectedCountry)
        return;
    
    [self.listView reloadData];
    
    NSUInteger selectedObjectIndex = [_countries indexOfObject:_selectedCountry];
    
    if (selectedObjectIndex != NSNotFound)
    {
        NSIndexPath * ip = [NSIndexPath indexPathForItem:selectedObjectIndex inSection:0];
        [self.listView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

#pragma mark - 搜索框代理方法 --


// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (!searchController.searchBar.text || searchController.searchBar.text.length <= 0) {
        self.countryData = [NSMutableArray arrayWithArray:_countries];
        return;
    }

    NSString *PString = [NSString stringWithFormat:@"countryCode CONTAINS [CD] '%@' or SELF.name CONTAINS [CD] '%@' or SELF.dialingCode CONTAINS [CD] '%@'",searchController.searchBar.text,searchController.searchBar.text,searchController.searchBar.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:PString];
    self.countrySearchResults = [NSMutableArray arrayWithArray:[self.countries filteredArrayUsingPredicate:predicate]];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.countryData = [NSMutableArray arrayWithArray:self.countrySearchResults];
        [self.listView reloadData];
    });
}

- (void)willDismissSearchController:(UISearchController *)searchController {

    self.countryData = [NSMutableArray arrayWithArray:self.countries];
    [self loadCountrySelection];
    
}

/* ScrollView delegate */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.listView) {
        [self.searchController.searchBar endEditing:YES];
    }
}
#pragma mark - 懒加载 --

- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectZero];
        _listView.delegate = self;
        _listView.dataSource = self;
        [_listView registerClass:[GLCountryCell class] forCellReuseIdentifier:countryPicker_listView_cell_id_1];
        if (@available(iOS 11.0, *)) {
            _listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _listView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.layer.masksToBounds = YES;
        _searchController.searchBar.layer.cornerRadius = 0.0;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.dimsBackgroundDuringPresentation = NO;
    }
    return _searchController;
}

- (NSLocale *)countryNameDisplayLocale {
    if (!_countryNameDisplayLocale) {
        _countryNameDisplayLocale = [NSLocale currentLocale];
    }
    return _countryNameDisplayLocale;
}

@end
