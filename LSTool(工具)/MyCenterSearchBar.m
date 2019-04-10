//
//  MyCenterSearchBar.m
//  XSGL
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 senlin. All rights reserved.
//

#import "MyCenterSearchBar.h"

// 占位文字的字体大小
static CGFloat const placeHolderFont = 15.0;


@implementation MyCenterSearchBar
- (void)layoutSubviews {
    
     [super layoutSubviews];

    for (UIView *view in [self.subviews lastObject].subviews) {
        
        if ([view isKindOfClass:[UITextField class]]) {
                
            UITextField *field = (UITextField *)view;
            // 重设field的frame
            field.frame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
            
            field.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                 
            field.borderStyle = UITextBorderStyleNone;
            field.layer.cornerRadius = 2.0f;
            field.layer.masksToBounds = YES;
            // 设置占位文字字体颜色
            [field setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
            [field setValue:[UIFont systemFontOfSize:placeHolderFont] forKeyPath:@"_placeholderLabel.font"];
            
            UIImageView *textLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0,5, 15, 15)];
            textLeftView.image = [UIImage imageNamed:@"searchBigGray"];
            field.leftView = textLeftView;
            
            if (@available(iOS 11.0, *)) {
            // 先默认居中placeholder
            [self setPositionAdjustment:UIOffsetMake((field.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
            }
        }
}
    
}
// 开始编辑的时候重置为靠左

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

        // 继续传递代理方法
        if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {

        [self.delegate searchBarShouldBeginEditing:self];
        }

        if (@available(iOS 11.0, *)) {[self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
        }

        return YES;

}

// 结束编辑的时候设置为居中

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

        if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {

        [self.delegate searchBarShouldEndEditing:self];

        }
        if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
        return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
