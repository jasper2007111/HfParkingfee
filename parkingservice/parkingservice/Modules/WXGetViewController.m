//
//  WXGetViewController.m
//  WXCustomCamera
//
//  Created by wx on 16/7/8.
//  Copyright © 2016年 WX. All rights reserved.
//

#import "WXGetViewController.h"
#import "WXHeader.h"
@interface WXGetViewController ()

@end

@implementation WXGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"获取图片的界面";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.getImages.size.width, self.getImages.size.height)];
    imageView.layer.cornerRadius = self.getImages.size.width/2;
    imageView.layer.masksToBounds = YES;
    imageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [imageView setImage:self.getImages];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
