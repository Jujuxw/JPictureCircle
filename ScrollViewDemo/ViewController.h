//
//  ViewController.h
//  ScrollViewDemo
//
//  Created by juju on 2017/3/7.
//  Copyright © 2017年 juju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageController;

@property (nonatomic, strong) NSMutableDictionary *imageDataDic;

@property (nonatomic, assign) int currentPageIndex;

@property (nonatomic, assign) int imageCount;

@end

