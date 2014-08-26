//
//  ViewController.h
//  SupViewTest
//
//  Created by Aaron Sutula on 8/26/14.
//  Copyright (c) 2014 Aaron Sutula. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end