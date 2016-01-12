//
//  SlideBarCollectionView.m
//  ZUIMEIDemo
//
//  Created by zhangle on 16/1/12.
//  Copyright © 2016年 zhangle. All rights reserved.
//

#import "SlideBarCollectionView.h"
#import "SlideBarViewCell.h"

@interface SlideBarCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation SlideBarCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2.5, 0, 2.5);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(50, frame.size.height);
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[SlideBarViewCell class] forCellWithReuseIdentifier:@"slideCell"];
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
        gesture.minimumPressDuration = 0;
        [self addGestureRecognizer:gesture];
        
    }
    return self;
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:self];
    NSArray *visibleCells = [self visibleCells];
    NSInteger count = visibleCells.count;
    for (SlideBarViewCell *cell in visibleCells) {
        if (CGRectContainsPoint(cell.frame, point)) {
            NSIndexPath *indexPath = [self indexPathForCell:cell];
            NSInteger idx = indexPath.row;
            
            for (NSInteger i = 0; i < count; i++) {
                indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                SlideBarViewCell *slideCell = (SlideBarViewCell *)[self cellForItemAtIndexPath:indexPath];
                [UIView animateWithDuration:0.25 animations:^{
                    slideCell.transform = CGAffineTransformMakeTranslation(0, -40 + 10 * ABS(i - idx));
                }];
            }
            break;
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        for (SlideBarViewCell *cell in visibleCells) {
            if (CGRectContainsPoint(cell.frame, point)) {
                NSIndexPath *indexPath = [self indexPathForCell:cell];
                [self showBarsWithIndexPath:indexPath];
                if ([_slideDelegate respondsToSelector:@selector(scrollPageAtIndexPath:)]) {
                    [_slideDelegate scrollPageAtIndexPath:indexPath];
                }
            }
        }
    }
}

- (void)selectBarAtIndexPath:(NSIndexPath *)indexPath {
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self showBarsWithIndexPath:indexPath];
}

- (void)showBarsWithIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i< self.subviews.count; i++){
        SlideBarViewCell *cell = (SlideBarViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:0 animations:^{
            
            if (i == indexPath.item) {
                cell.transform = CGAffineTransformMakeTranslation(0, -50);
            }else{
                cell.transform = CGAffineTransformIdentity;
            }
            
        } completion:nil];
    }
}

#pragma mark -
#pragma mark - UICollectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_iconArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SlideBarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"slideCell" forIndexPath:indexPath];
    return cell;
}

@end
















