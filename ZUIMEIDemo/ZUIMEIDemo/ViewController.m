//
//  ViewController.m
//  ZUIMEIDemo
//
//  Created by zhangle on 16/1/12.
//  Copyright © 2016年 zhangle. All rights reserved.
//

#import "ViewController.h"
#import "SlideBarCollectionView.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, SlideBarCollectionViewDelegate>

@property (weak, nonatomic) SlideBarCollectionView *slideBarView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    
    SlideBarCollectionView *slideBarView = [[SlideBarCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 70, CGRectGetWidth(self.view.bounds), 140)];
    slideBarView.slideDelegate = self;
    slideBarView.iconArray = array;
    [self.view addSubview:slideBarView];
    _slideBarView = slideBarView;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nice" forIndexPath:indexPath];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger itemPage = floorf(offset / CGRectGetWidth(self.view.bounds));
    [_slideBarView selectBarAtIndexPath:[NSIndexPath indexPathForItem:itemPage inSection:0]];
    
}

- (void)scrollPageAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
