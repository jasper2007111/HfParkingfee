//
//  NPCarNoInputView.m
//  Demo
//
//  Created by HzB on 2017/1/5.
//  Copyright © 2017年 Matías Martínez. All rights reserved.
//

#import "NPCarNoInputView.h"
#import "NPCarNoKeyboard.h"

@interface NPCarNoInputView()<NPCarNoKeyboardDelegate>

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,weak)NPCarNoKeyboard *keyboard;

@end

@implementation NPCarNoInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI{

    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //
    NPCarNoKeyboard *keyboard = [[NPCarNoKeyboard alloc] initWithFrame:CGRectZero];
    keyboard.delegate = self;
    
    // Configure an example UITextField.
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat width = 280.0;
    CGFloat height = 66.0;
    CGFloat x = (screenWidth - width) / 2.0;
    CGFloat y =  80.0 * screenHeight / 568.0;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
    textField.inputView = keyboard;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.font = [UIFont boldSystemFontOfSize:25.0];
    textField.textColor = [UIColor whiteColor];
    textField.layer.borderWidth = 3.0;
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImage *image = [UIImage imageNamed:@"point_NPCarNoKeyboard"];
    height = image.size.height + 10.0;
    width = image.size.width + 20.0;
    UIImageView *leftView = [[UIImageView alloc]initWithImage:image];
    leftView.frame = CGRectMake(x, y, width, height);
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;

    UIImageView *rightView = [[UIImageView alloc]initWithImage:image];
    rightView.frame = CGRectMake(x, y, width, height);
    rightView.contentMode = UIViewContentModeScaleAspectFit;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;

    
     _textField = textField;
    _keyboard = keyboard;
    [self addSubview:textField];
    //
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    //
    if (_carNo.length > 0) {
        _textField.text = _carNo;
        _keyboard.leftToolButtonTitle = @"完成";
    }
    [_textField becomeFirstResponder];
}

- (void)dismiss{
    __weak typeof(self) weakSelf = self;
    [_textField resignFirstResponder];
    [UIView animateWithDuration:.06 animations:^{
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

//

- (BOOL)carNoKeyboard:(NPCarNoKeyboard *)carNoKeyboard shouldInsertText:(NSString *)text{
    //如果有旧车牌，没删除前，点击没效果，更改后将旧的车牌清除
    if (_carNo && [_textField.text isEqualToString:_carNo]) {
        return NO;
    }
    _carNo = nil;
    _keyboard.leftToolButtonTitle = @"取消";
    return YES;
}

- (void)carNoKeyboard:(NPCarNoKeyboard *)carNoKeyboard
        endInsertText:(NSString *)text{
    NSMutableString *carNo = [NSMutableString stringWithString:_textField.text];
    if (carNo.length >= 7) {
        if (_inputBlock) {
            _inputBlock(carNo);
        }
        [self dismiss];
    }
}

- (BOOL)carNoKeyboardShouldCancel:(NPCarNoKeyboard *)carNoKeyboard{
    [self dismiss];
    return YES;
}

- (BOOL)carNoKeyboardShouldDeleteBackward:(NPCarNoKeyboard *)carNoKeyboard{
    _keyboard.leftToolButtonTitle = @"取消";
    return YES;
}


@end
