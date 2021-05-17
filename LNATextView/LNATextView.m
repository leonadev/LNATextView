//
//  LNATextView.m
//  LNATextView
//
//  Created by leonadev on 2021/5/17.
//

#import "LNATextView.h"

@interface LNATextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation LNATextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceholderText) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceholderText) name:UITextViewTextDidBeginEditingNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    if (self.placeholder && [self.placeholder isKindOfClass:[NSString class]] && self.placeholder.length > 0) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat w = self.bounds.size.width - x - textContainerInset.right - 2 * self.layer.borderWidth;
        CGFloat h = [self.placeholderLabel sizeThatFits:CGSizeMake(w, 0)].height;
        self.placeholderLabel.frame = CGRectMake(x, y, w, h);
    }
    [super layoutSubviews];
}

- (void)updatePlaceholderText {
    if (self.text && self.text.length > 0) {
        self.placeholderLabel.hidden = YES;
        return;
    }
    if (!self.placeholderLabel.superview) {
        self.placeholderLabel.font = _placeholderFont ? : (self.font ? : [UIFont systemFontOfSize:14]);
        self.placeholderLabel.textColor = _placeholderColor ? : [UIColor lightGrayColor];
        self.placeholderLabel.textAlignment = self.textAlignment;
        [self insertSubview:self.placeholderLabel atIndex:0];
    }
    if (self.placeholderLabel.text != _placeholder) {
        self.placeholderLabel.text = _placeholder;
    }
    self.placeholderLabel.hidden = NO;
}

#pragma mark - Getter & Setter
- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
    }
    return _placeholderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self updatePlaceholderText];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self updatePlaceholderText];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self updatePlaceholderText];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self updatePlaceholderText];
}

@end
