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
@property (nonatomic, strong) CADisplayLink *link;
@end

@implementation ViewController

- (void)updateLayout:(CADisplayLink *)sender
{
    static CGFloat const kTransitionInterval = 0.05;
    MyLayout *layout = (MyLayout *)self.collectionView.collectionViewLayout;
    if (layout.displaySup)
    {
        layout.transition += kTransitionInterval;
    }
    else
    {
        layout.transition -= kTransitionInterval;
    }
    
    [layout invalidateLayout];
    
    if ((layout.displaySup && layout.transition >= 1) ||
        (!layout.displaySup && layout.transition <= 0))
    {
        [self.link invalidate];
        self.link = nil;
    }
}

- (IBAction)add:(id)sender
{
    MyLayout *layout = (MyLayout *)self.collectionView.collectionViewLayout;
    layout.displaySup = YES;
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLayout:)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (IBAction)remove:(id)sender
{
    MyLayout *layout = (MyLayout *)self.collectionView.collectionViewLayout;
    layout.displaySup = NO;
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLayout:)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
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