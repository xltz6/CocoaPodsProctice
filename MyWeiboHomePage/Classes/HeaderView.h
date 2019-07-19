//
//  HeaderView.h
//  HomePagePractice
//
//  Created by liuxuan on 2019/7/9.
//  Copyright © 2019 liuxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *headerImage;
@property (nonatomic, weak) HMSegmentedControl *segControl;
//@property (nonatomic, assign) BOOL canNotResponseTapTouchEvent;
@end

NS_ASSUME_NONNULL_END
