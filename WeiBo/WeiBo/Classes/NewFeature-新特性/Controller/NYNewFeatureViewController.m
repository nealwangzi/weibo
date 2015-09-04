//
//  NYNewFeatureViewController.m
//  WeiBo
//
//  Created by Apple on 15/9/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NYNewFeatureViewController.h"
#import "NYNewFeatureCell.h"
@interface NYNewFeatureViewController ()
/* items */
@property(nonatomic , strong) NSArray *items;

@end

@implementation NYNewFeatureViewController

static NSString * const reuseIdentifier = @"NewFeatureCell";

- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize =[UIScreen mainScreen].bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0 ;
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = @[@"new_feature_1",
                   @"new_feature_2",
                   @"new_feature_3",
                   @"new_feature_4"];
    
    [self setupCollectionView];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)setupCollectionView
{
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"NYNewFeatureCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NYNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imagename = self.items[indexPath.item];
    [cell setIndexPath:indexPath count:self.items.count];
    return cell;
}

@end
