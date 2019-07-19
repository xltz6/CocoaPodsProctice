//
//  HeaderView.m
//  HomePagePractice
//
//  Created by liuxuan on 2019/7/9.
//  Copyright © 2019 liuxuan. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@end


@implementation HeaderView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.backgroundColor = [UIColor grayColor];
        _headerImage = imageview;
        [self addSubview:_headerImage];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        _nameLabel = label;
        [self addSubview:_nameLabel];
        
        HMSegmentedControl *seg = [[HMSegmentedControl alloc] init];
        seg.backgroundColor = [UIColor grayColor];
        _segControl = seg;
        [self addSubview:_segControl];
        
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //    self.headerImage.frame = CGRectMake(0, -160, 320, 360);
    //    self.segCtrl.frame = CGRectMake(0, 200, 320, 40);
    
    [_headerImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    //add constraints for headerImage:
    NSLayoutConstraint *headerImageConstraintTop = [NSLayoutConstraint constraintWithItem:_headerImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:-160];
    NSLayoutConstraint *headerImageConstraintLeft = [NSLayoutConstraint constraintWithItem:_headerImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *headerImageConstraintBottom = [NSLayoutConstraint constraintWithItem:_headerImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_segControl attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *headerImageConstraintRight = [NSLayoutConstraint constraintWithItem:_headerImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *headerImageConstraintHeight = [NSLayoutConstraint constraintWithItem:_headerImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:360];
    
    [self addConstraints:@[headerImageConstraintTop, headerImageConstraintLeft, headerImageConstraintBottom, headerImageConstraintRight]];
    [_headerImage addConstraint:headerImageConstraintHeight];
    
    [_segControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    //add constraints for segment control:
    NSLayoutConstraint *segCtrlConstraintTop = [NSLayoutConstraint constraintWithItem:_segControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_headerImage attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *segCtrlConstraintLeft = [NSLayoutConstraint constraintWithItem:_segControl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *segCtrlConstraintBottom = [NSLayoutConstraint constraintWithItem:_segControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *segCtrlConstraintRight = [NSLayoutConstraint constraintWithItem:_segControl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self addConstraints:@[segCtrlConstraintTop, segCtrlConstraintLeft, segCtrlConstraintBottom, segCtrlConstraintRight]];
    
}

@end

