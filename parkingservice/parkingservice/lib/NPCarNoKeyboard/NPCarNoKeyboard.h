//
//  NPCarNoKeyboard.h
//  Demo
//
//  Created by HzB on 2017/1/5.
//  Copyright © 2017年 Matías Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NPCarNoKeyboardShowType){
    NPCarNoKeyboardShowTypeHead,
    NPCarNoKeyboardShowTypeTail,
};

@class NPCarNoKeyboard;

@protocol NPCarNoKeyboardDelegate <NSObject>
@optional

- (BOOL)carNoKeyboard:(NPCarNoKeyboard *)carNoKeyboard
     shouldInsertText:(NSString *)text;

- (void)carNoKeyboard:(NPCarNoKeyboard *)carNoKeyboard
        endInsertText:(NSString *)text;

- (BOOL)carNoKeyboardShouldCancel:(NPCarNoKeyboard *)carNoKeyboard;

- (BOOL)carNoKeyboardShouldDeleteBackward:(NPCarNoKeyboard *)carNoKeyboard;

@end


@interface NPCarNoKeyboard : UIInputView

@property (weak, nonatomic) id <UIKeyInput> keyInput;

@property (weak, nonatomic) id <NPCarNoKeyboardDelegate> delegate;

@property (copy, nonatomic) NSString *leftToolButtonTitle;

- (void)showTypw:(NPCarNoKeyboardShowType)type;

@end
