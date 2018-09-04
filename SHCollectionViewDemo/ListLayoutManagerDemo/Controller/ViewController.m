//
//  ViewController.m
//  ListLayoutManagerDemo
//
//  Created by 张晓珊 on 2018/8/16.
//  Copyright © 2018年 张晓珊. All rights reserved.
//

#import "ViewController.h"
#import "SHCollectionViewManager.h"
#import "ViewModel.h"
#import "CollectionViewCell.h"
#import "CollectionHeaderView.h"

@interface ViewController ()<SHCollectionViewManagerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SHCollectionViewManager *manager;
@property (nonnull, nonatomic, strong) ViewModel *viewModel;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewModel loadData];
    [self.collectionView reloadData];
}


- (void)didSelectWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第%zd组，第%zd个cell被点击了", indexPath.section, indexPath.item);
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 25;
        layout.minimumInteritemSpacing = 25;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame: [UIScreen mainScreen].bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:CollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(CollectionViewCell.class)];
        [collectionView registerClass:CollectionHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(CollectionHeaderView.class)];
        
        collectionView.delegate = self.manager;
        collectionView.dataSource = self.manager;
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (SHCollectionViewManager *)manager {
    if (!_manager) {
        SHCollectionViewManager *manager = [SHCollectionViewManager new];
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
