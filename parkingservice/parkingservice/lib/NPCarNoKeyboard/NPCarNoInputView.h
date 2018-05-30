//
//  NPCarNoInputView.h
//  Demo
//
//  Created by HzB on 2017/1/5.
//  Copyright © 2017年 Matías Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NPCarNoInputBlock)(NSString *carNo);

@interface NPCarNoInputView : UIView

@property (nonatomic,copy) NSString *carNo;
@property (nonatomic,copy) NPCarNoInputBlock inputBlock;

- (void)show;
- (void)dismiss;

@end
