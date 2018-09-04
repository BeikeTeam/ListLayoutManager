//
//  ViewController.m
//  ListLayoutManager
//
//  Created by 张晓珊 on 2018/8/19.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "ViewController.h"
#import "CustomHeaderView.h"
#import "CustomLabelCell.h"
#import "CustomImageCell.h"
#import "CustomButtonCell.h"
#import "HouseDetailsViewController.h"
#import "SHListLayoutManagerProtocol.h"
#import "SHTableViewManager.h"
#import "ViewModel.h"

@interface ViewController () <SHTableViewManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SHTableViewManager *manager;
@property (nonnull, nonatomic, strong) ViewModel *viewModel;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    [self setUpUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)setUpUI {
    [self.view addSubview:self.tableView];
    
    NSLayoutConstraint *tableViewTop = [self.tableView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
    NSLayoutConstraint *tableViewLeading = [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    NSLayoutConstraint *tableViewBottom = [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    NSLayoutConstraint *tableViewTrailing = [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[tableViewTop, tableViewLeading, tableViewBottom, tableViewTrailing]];

}

- (void)loadData {
    
    [self.viewModel loadData];
    
    [self.tableView reloadData];
}


#pragma mark - SHTableViewManagerDelegate

- (void)configTableViewCell:(UITableViewCell *)cell {
    if ([cell isKindOfClass:CustomButtonCell.class]) {
        CustomButtonCell *currentCell = (CustomButtonCell *)cell;
        __weak typeof (self) weakSelf = self;
        currentCell.buttonClickBlock = ^(UIButton *sinder) {
            [weakSelf.tableView reloadData];
        };
    }
}

- (void)configTableViewHeaderFooterView:(UITableViewHeaderFooterView *)view {
    if ([view isKindOfClass:CustomHeaderView.class]) {
        CustomHeaderView *header = (CustomHeaderView *)view;
        __weak typeof (self) weakSelf = self;
        header.buttonClickBlock = ^(UIButton *sinder) {
            [weakSelf.tableView reloadData];
        };
    }
}

- (void)didSelectWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    id<SHListLayoutSectionModelable> section = self.viewModel.sections[indexPath.section];
    id model = section.items[indexPath.row];
    
    HouseDetailsViewController *controller = [HouseDetailsViewController new];
    if ([model isKindOfClass:CustomLabelCellModel.class]) {
        CustomLabelCellModel *cellModel = model;
        controller.houseId = cellModel.houseId;
    }else if ([model isKindOfClass:CustomImageCellModel.class]) {
        CustomImageCellModel *cellModel = model;
        controller.houseId = cellModel.houseId;
    }else if ([model isKindOfClass:CustomButtonCellModel.class]) {
        CustomButtonCellModel *cellModel = model;
        controller.houseId = cellModel.houseId;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.delegate = self.manager;
        tableView.dataSource = self.manager;
        [tableView registerClass:CustomLabelCell.class forCellReuseIdentifier:NSStringFromClass(CustomLabelCell.class)];
        [tableView registerClass:CustomImageCell.class forCellReuseIdentifier:NSStringFromClass(CustomImageCell.class)];
        [tableView registerClass:CustomButtonCell.class forCellReuseIdentifier:NSStringFromClass(CustomButtonCell.class)];
        [tableView registerClass:CustomHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(CustomHeaderView.class)];
        _tableView = tableView;
    }
    return _tableView;
}

- (SHTableViewManager *)manager {
    if (!_manager) {
        SHTableViewManager *manager = [SHTableViewManager new];
        manager.delegate = self;
        manager.listModel = self.viewModel;
        _manager = manager;
    }
    
    return _manager;
}

- (ViewModel *)viewModel {
    if (!_viewModel) {
        ViewModel *viewModel = [ViewModel new];
        _viewModel = viewModel;
    }
    
    return _viewModel;
}

@end
