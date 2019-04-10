//
//  MyCenterSearchBar.h
//  XSGL
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 senlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCenterSearchBar : UISearchBar<UITextFieldDelegate>

// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end
