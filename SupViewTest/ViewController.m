//
//  ViewController.m
//  SupViewTest
//
//  Created by Aaron Sutula on 8/26/14.
//  Copyright (c) 2014 Aaron Sutula. All rights reserved.
//

#import "ViewController.h"
#import "MyLayout.h"
#import "MySupView.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)add:(id)sender
{
    MyLayout *layout = (MyLayout *)self.collectionView.collectionViewLayout;
    layout.displaySup = YES;
    
//    [layout invalidateLayout];
    
    [self.collectionView performBatchUpdates:^{
        [layout invalidateLayout];
    } completion:nil];
}

- (IBAction)remove:(id)sender
{
    MyLayout *layout = (MyLayout *)self.collectionView.collectionViewLayout;
    layout.displaySup = NO;
    
//    [layout invalidateLayout];
    
    [self.collectionView performBatchUpdates:^{
        [layout invalidateLayout];
    } completion:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MySupView *view = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kind forIndexPath:indexPath];
    view.backgroundColor = [UIColor purpleColor];
    return view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[MySupView class] forSupplementaryViewOfKind:@"supView" withReuseIdentifier:@"supView"];
    
    [self.collectionView setCollectionViewLayout:[[MyLayout alloc] init]];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end