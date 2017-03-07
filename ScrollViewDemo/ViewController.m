//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by juju on 2017/3/7.
//  Copyright © 2017年 juju. All rights reserved.
//

#import "ViewController.h"

#define IMAGEVIEW_COUNT 3

#define KWIDTH self.view.frame.size.width

#define KHEIGHT self.view.frame.size.height

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isDragging;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollView];
    
    [self loadData];
    
    [self addImageViews];
    
    [self addPageController];
    
    [self setDefaultImage];
    
    [self addTimer];
}

- (void)addTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    
    [runloop addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)nextImage {
    
    if (_isDragging == YES) {
        return;
    }

    [self reloadImages];
    
    if (_pageController.currentPage == _imageCount - 1) {
        
        _pageController.currentPage = 0;
    } else {
        
        _pageController.currentPage ++;
    }
    
}

- (void)addScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    
    _scrollView.delegate = self;
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.contentSize = CGSizeMake(IMAGEVIEW_COUNT * KWIDTH, KHEIGHT);
    
    _scrollView.bounces = NO;
    
    [_scrollView setContentOffset:CGPointMake(KWIDTH, 0) animated:NO];
    
    [self.view addSubview:_scrollView];
}

- (void)loadData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ImageList" ofType:@"plist"];
    
    _imageDataDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    _imageCount = (int)_imageDataDic.count;
    
    NSLog(@"%@",_imageDataDic);
}

- (void)addImageViews {
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_leftImageView];
    
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH, 0, KWIDTH, KHEIGHT)];
    
    _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_centerImageView];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake((IMAGEVIEW_COUNT - 1) * KWIDTH, 0, KWIDTH, KHEIGHT)];
    
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_rightImageView];
}

- (void)setDefaultImage {
    
    _rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", _imageCount - 1]];
    
    _centerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", 0]];
    
    _leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", 1]];
    
//    _currentPageIndex = 0;
    
    _pageController.currentPage = _currentPageIndex;
}

- (void)addPageController {
    
    _pageController = [[UIPageControl alloc] init];
    
    CGSize size = [_pageController sizeForNumberOfPages:_imageCount];
    
    _pageController.bounds = CGRectMake(0, 0, size.width, size.height);
    
    _pageController.center = CGPointMake(KWIDTH / 2, KHEIGHT - 100);

    _pageController.numberOfPages = _imageCount;
    
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
    
    _pageController.currentPageIndicatorTintColor = [UIColor blackColor];
    
    [self.view addSubview:_pageController];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _isDragging = YES;
    
    [_timer invalidate];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _isDragging = NO;
    
    [self addTimer];
    
    [self reloadImages];
    
    [_scrollView setContentOffset:CGPointMake(KWIDTH, 0) animated:NO];
    
    _pageController.currentPage = _currentPageIndex;
}


- (void)reloadImages {
    
    int leftImageIndex, rightImageIndex;
    
    CGPoint offSet = [_scrollView contentOffset];
    
    if (offSet.x == 2 * KWIDTH) {
        
        _currentPageIndex = (_currentPageIndex + 1) % _imageCount;
        
    } else if (offSet.x == KWIDTH) {
        
        _currentPageIndex = (_currentPageIndex + _imageCount -1) % _imageCount;
    }
    
    _centerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.JPG", _currentPageIndex]];
    
    
    leftImageIndex = (_currentPageIndex + _imageCount - 1) % _imageCount;
    
    rightImageIndex = (_currentPageIndex + 1) % _imageCount;
    
    _leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.JPG", leftImageIndex]];
    
    _rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.JPG", rightImageIndex]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
