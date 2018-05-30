//
//  NPCarNoKeyboard.m
//  Demo
//
//  Created by HzB on 2017/1/5.
//  Copyright © 2017年 Matías Martínez. All rights reserved.
//

#import "NPCarNoKeyboard.h"
#import <objc/runtime.h>

#define MainWidth_NPCarNo   [[UIScreen mainScreen] bounds].size.width
#define MainHeight_NPCarNo   [[UIScreen mainScreen] bounds].size.height


#pragma mark - UITableViewCell
static NSString *NPCarNoCell_ID = @"NPCarNoCellID";
static const CGFloat NPCarNoCellHeight = 44.0;

@class NPCarNoCell;
@protocol NPCarNoCellDelegate <NSObject>;

- (void)carNoCell:(NPCarNoCell *)cell
     buttonAction:(UIButton *)button;

@end

@interface NPCarNoCell : UITableViewCell

@property (nonatomic,weak) id<NPCarNoCellDelegate> delegate;
@property (nonatomic,strong,readonly) NSMutableArray *buttonList;
@property (nonatomic, strong,readonly) UIView *lineView;
@property (nonatomic, strong) NSArray *titleList;

@end


@implementation NPCarNoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
                      rowNum:(NSInteger)rowNum
             reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat height = NPCarNoCellHeight;
        CGFloat lineViewWidth = 1.0;
        CGFloat width = (MainWidth_NPCarNo - lineViewWidth * (rowNum -1))/ (float)rowNum;
        
        _buttonList = [[NSMutableArray alloc]init];
        for (int i = 0; i < rowNum; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(x, y, width, height);
            button.titleLabel.font = [UIFont systemFontOfSize:16.0];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(buttonDownAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            [_buttonList addObject:button];
            
            //
            if (i != rowNum - 1) {
                UIView *lineView = [[UIView alloc]init];
                lineView.frame = CGRectMake(x + width, 0, lineViewWidth, height);
                lineView.backgroundColor = [UIColor lightGrayColor];
                [self.contentView addSubview:lineView];
            }
            x += width + lineViewWidth;
        }
        
        
        //
        UIView *lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, NPCarNoCellHeight - 1.0, MainWidth_NPCarNo, 1.0);
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return self;
}

- (void)setTitleList:(NSArray *)titleList{
    
    for (int i = 0; i < _buttonList.count; i++) {
       
        UIButton *button = [_buttonList objectAtIndex:i];
        if (titleList.count > i) {
            [button setTitle:titleList[i] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
        }else{
            [button setTitle:@"" forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
        }
    }
}

- (void)buttonAction:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(carNoCell:buttonAction:)]) {
        [_delegate carNoCell:self buttonAction:button];
    }
}

- (void)buttonDownAction:(UIButton *)button{
    [[UIDevice currentDevice] playInputClick];
}

@end

#pragma mark - NPCarNoTableView

@class NPCarNoTableView;
@protocol NPCarNoTableViewDelegate <NSObject>

- (void)carNoTableView:(NPCarNoTableView *)tableView
      didSelectedTitle:(NSString *)title;

@end

@interface NPCarNoTableView : UITableView
<UITableViewDelegate,
UITableViewDataSource,
NPCarNoCellDelegate>

@property (nonatomic,weak) id<NPCarNoTableViewDelegate> carNoDelegate;
@property (nonatomic,strong,readonly) NSArray *dataList;
@property (nonatomic,assign,readonly) NSInteger rowNum;

- (instancetype)initWithFrame:(CGRect)frame
                       rowNum:(NSInteger)rowNum
                     dataList:(NSArray *)dataList;

@end

@implementation NPCarNoTableView


- (instancetype)initWithFrame:(CGRect)frame
                       rowNum:(NSInteger)rowNum
                   dataList:(NSArray *)dataList{
    
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        _rowNum = rowNum;
        self.dataList = dataList;
        self.rowHeight = NPCarNoCellHeight;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth_NPCarNo, 0.0)];
        
    }
    return self;
}

- (void)setDataList:(NSArray *)dataList{
    _dataList = nil;
    //
    NSMutableArray *rowList = [[NSMutableArray alloc]init];
    NSMutableArray *dataSource = [[NSMutableArray alloc]init];
    for (int i = 0; i < dataList.count; i++) {
        
        [rowList addObject:[dataList objectAtIndex:i]];
        if ( (i+1) % _rowNum  ==  0) {
            [dataSource addObject:rowList];
            rowList = [[NSMutableArray alloc]init];
        }
    }
    if (![dataSource containsObject:rowList] && rowList.count > 0) {
        [dataSource addObject:rowList];
    }
    
    //
    _dataList = dataSource;
}

/// tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NPCarNoCell *cell = [tableView dequeueReusableCellWithIdentifier:NPCarNoCell_ID];
    if (!cell) {
        cell = [[NPCarNoCell alloc]initWithStyle:UITableViewCellStyleDefault rowNum:_rowNum reuseIdentifier:NPCarNoCell_ID];
        cell.delegate = self;
    }
    cell.titleList = [_dataList objectAtIndex:indexPath.row];
    return cell;
}

- (void)carNoCell:(NPCarNoCell *)cell buttonAction:(UIButton *)button{
    if (_carNoDelegate && [_carNoDelegate respondsToSelector:@selector(carNoTableView:didSelectedTitle:)]) {
        [_carNoDelegate carNoTableView:self didSelectedTitle:button.currentTitle];
    }
}

@end


#pragma mark - NPCarNoKeyboard

static __weak id currentFirstResponder;

@implementation UIResponder (FirstResponder)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-repeated-use-of-weak"
+ (id)NP_currentFirstResponder
{
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(NP_findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}
#pragma clang diagnostic pop
- (void)NP_findFirstResponder:(id)sender{
    currentFirstResponder = self;
}

@end

///增大按钮的点击范围
@interface UIButton (_NPKBboard)
- (void)_setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;
@end


@interface NPCarNoKeyboard()<NPCarNoTableViewDelegate>

@property (strong, nonatomic) NSLocale *locale;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *backspaceButton;
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NPCarNoTableView *headTableView;
@property (strong, nonatomic) NPCarNoTableView *moreTableView;

@end

@implementation NPCarNoKeyboard

#define NPCarNoKBLocalizedString(key) [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] localizedStringForKey:key value:@"" table:nil]

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame inputViewStyle:UIInputViewStyleKeyboard];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame inputViewStyle:(UIInputViewStyle)inputViewStyle
{
    self = [super initWithFrame:frame inputViewStyle:inputViewStyle];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame inputViewStyle:(UIInputViewStyle)inputViewStyle locale:(NSLocale *)locale
{
    self = [super initWithFrame:frame inputViewStyle:inputViewStyle];
    if (self) {
        self.locale = locale;
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit
{
    CGFloat spaceX = 12.0;
    //
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = 46.0;
    CGFloat width = MainWidth_NPCarNo;
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    toolView.backgroundColor = [UIColor whiteColor];
    [self addSubview:toolView];
    
    //
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    UIColor *norColor = [UIColor colorWithRed:44.0/255.0 green:170.0/255.0  blue:232.0/255.0  alpha:1.0];
    [_cancelButton setTitleColor:norColor forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton sizeToFit];
    CGRect frame = _cancelButton.frame;
    frame.origin.x = spaceX;
    frame.origin.y = (height - frame.size.height) / 2.0;
    _cancelButton.frame = frame;
    [_cancelButton _setEnlargeEdgeWithTop:12.0 right:26.0 bottom:12.0 left:12.0];
    [toolView addSubview:_cancelButton];
    
    //
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:16.0];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"点击选择车牌号";
     width = [_titleLabel sizeThatFits:CGSizeMake(0, height)].width + 10.0;
     x = (MainWidth_NPCarNo - width) / 2.0;
    _titleLabel.frame = CGRectMake(x, y, width, height);
    [toolView addSubview:_titleLabel];
    
    //
    _backspaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backspaceButton setImage:[UIImage imageNamed:@"back_NPCarNoKeyboard"] forState:UIControlStateNormal];
    [_backspaceButton addTarget:self action:@selector(backspaceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backspaceButton sizeToFit];
    frame = _backspaceButton.frame;
    frame.origin.x = MainWidth_NPCarNo - spaceX - frame.size.width;
    frame.origin.y = (height - frame.size.height) / 2.0;
    _backspaceButton.frame = frame;
    [_backspaceButton _setEnlargeEdgeWithTop:12.0 right:12.0 bottom:12.0 left:26.0];
    [toolView addSubview:_backspaceButton];
    
    //
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, CGRectGetMaxY(toolView.frame), MainWidth_NPCarNo, 1.0);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];

    //主键盘
    x = 0;
    y = CGRectGetMaxY(lineView.frame);
    width = MainWidth_NPCarNo;
    height = 6 * NPCarNoCellHeight;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    

    //
    NSArray *list = @[@"京",@"津",@"沪",@"渝",@"冀",@"豫",
                      @"鲁",@"晋",@"陕",@"皖",@"苏",@"浙",
                      @"鄂",@"湘",@"赣",@"闽",@"粤",@"桂",
                      @"琼",@"川",@"贵",@"云",@"辽",@"吉",
                      @"黑",@"蒙",@"甘",@"宁",@"青",@"新",
                      @"藏"];
    ///,@"港",@"澳",@"台"
    
    y = 0;
    _headTableView = [[NPCarNoTableView alloc]initWithFrame:CGRectMake(x, y, width, height) rowNum:6 dataList:list];
    _headTableView.carNoDelegate = self;
    [_scrollView addSubview:_headTableView];
    
    //
    NSMutableArray *moreList = [[NSMutableArray alloc]init];
    for (char ch = 'A'; ch <= 'Z'; ch++) {
        NSString *str = [NSString stringWithFormat:@"%c",ch];
        [moreList addObject:str];
    }
    [moreList removeObject:@"I"];
    [moreList removeObject:@"O"];
    
    for (int i = 0; i <= 9 ; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [moreList addObject:str];
    }

    //
    x += width;
    _moreTableView = [[NPCarNoTableView alloc]initWithFrame:CGRectMake(x, y, width, height) rowNum:6 dataList:moreList];
    _moreTableView.carNoDelegate = self;
    [_scrollView addSubview:_moreTableView];
    
    //
    lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(x-1.0, y, 2.0, height);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:lineView];

    //
    _scrollView.contentSize = CGSizeMake(2.0*width, 0.0);
    
    // Size to fit.
    [self sizeToFit];
}

- (void)setLeftToolButtonTitle:(NSString *)leftToolButtonTitle{
    if (_leftToolButtonTitle == leftToolButtonTitle) {
        return;
    }
    _leftToolButtonTitle = leftToolButtonTitle;
    [_cancelButton setTitle:_leftToolButtonTitle forState:UIControlStateNormal];
}

- (void)showTypw:(NPCarNoKeyboardShowType)type{
    if (type == NPCarNoKeyboardShowTypeHead) {
          [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (NPCarNoKeyboardShowTypeTail){
        [_scrollView setContentOffset:CGPointMake(MainWidth_NPCarNo, 0) animated:YES];
    }
}

- (CGSize)sizeThatFits:(CGSize)size{
    size.height = 46.0 + 6.0 *NPCarNoCellHeight;
    
    if (size.width == 0.0f) {
        size.width = [UIScreen mainScreen].bounds.size.width;
    }
    return size;
}

- (id<UIKeyInput>)keyInput
{
    id <UIKeyInput> keyInput = _keyInput;
    if (keyInput) {
        return keyInput;
    }
    
    keyInput = [UIResponder NP_currentFirstResponder];
    if (![keyInput conformsToProtocol:@protocol(UITextInput)]) {
        NSLog(@"Warning: First responder %@ does not conform to the UIKeyInput protocol.", keyInput);
        return nil;
    }
    
    _keyInput = keyInput;
    return keyInput;
}


- (void)carNoTableView:(NPCarNoTableView *)tableView didSelectedTitle:(NSString *)title{
    
    // Get first responder.
    id <UIKeyInput> keyInput = self.keyInput;
    id <NPCarNoKeyboardDelegate> delegate = self.delegate;
    if (!keyInput) {
        return;
    }
  
    // Handle number.
    if ([delegate respondsToSelector:@selector(carNoKeyboard:shouldInsertText:)]) {
        BOOL shouldInsert = [delegate carNoKeyboard:self shouldInsertText:title];
        if (!shouldInsert) {
            return;
        }
    }
    
    if (tableView == _headTableView){
        if (_scrollView.contentOffset.x <= MainWidth_NPCarNo / 2.0) {
            [self showTypw:NPCarNoKeyboardShowTypeTail];
        }
        if ([keyInput hasText]) {
            return;
        }
    }
    [keyInput insertText:title];
    
    //
    if ([delegate respondsToSelector:@selector(carNoKeyboard:endInsertText:)]) {
        [delegate carNoKeyboard:self endInsertText:title];
    }
}

#pragma mark - Action
- (void)backspaceButtonAction:(UIButton *)button{

    id <UIKeyInput> keyInput = self.keyInput;
    id <NPCarNoKeyboardDelegate> delegate = self.delegate;
    if (!keyInput) {
        return;
    }
    
    //
    BOOL shouldDeleteBackward = YES;
    
    if (delegate && [delegate respondsToSelector:@selector(carNoKeyboardShouldDeleteBackward:)]) {
        shouldDeleteBackward = [delegate carNoKeyboardShouldDeleteBackward:self];
    }
    
    if (shouldDeleteBackward) {
        [keyInput deleteBackward];
    }
    if (![keyInput hasText]) {
        [self showTypw:NPCarNoKeyboardShowTypeHead];
    }
}

- (void)cancelButtonAction:(UIButton *)button{
    id <NPCarNoKeyboardDelegate> delegate = self.delegate;
    if (delegate && [delegate respondsToSelector:@selector(carNoKeyboardShouldCancel:)]) {
        [delegate carNoKeyboardShouldCancel:self];
    }
}

@end




#pragma mark -
#pragma mark - NPEnlargeEdge 增大按钮的点击范围
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (_NPKBboard)

- (void)_setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)_enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else{
        return self.bounds;
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect rect = [self _enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end

