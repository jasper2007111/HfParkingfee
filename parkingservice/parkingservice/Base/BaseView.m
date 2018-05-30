//
//  BaseView.m
//  StarShop
//
//

#import "BaseView.h"

@implementation BaseView

#pragma mark- Layout

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    
    [self layoutSubviews];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
