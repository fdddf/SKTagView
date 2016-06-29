//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@interface SKTagButton ()
@property(nonatomic, strong) SKTag *tagObj;
@end

@implementation SKTagButton

+ (instancetype)buttonWithTag: (SKTag *)tag {
    SKTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
    btn.tagObj = tag;
    
    if (tag.attributedText) {
        [btn setAttributedTitle: tag.attributedText forState: UIControlStateNormal];
    } else {
        [btn setTitle: tag.text forState:UIControlStateNormal];
        [btn setTitleColor: tag.textColor forState: UIControlStateNormal];
        btn.titleLabel.font = tag.font ?: [UIFont systemFontOfSize: tag.fontSize];
    }
    
    btn.backgroundColor = tag.bgColor;
    btn.contentEdgeInsets = tag.padding;
    btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if (tag.bgImg) {
        [btn setBackgroundImage: tag.bgImg forState: UIControlStateNormal];
    }
    
    if (tag.borderColor) {
        btn.layer.borderColor = tag.borderColor.CGColor;
    }
    
    if (tag.borderWidth) {
        btn.layer.borderWidth = tag.borderWidth;
    }
    
    btn.userInteractionEnabled = tag.enable;
    if (tag.enable) {
        UIColor *highlightedBgColor = tag.highlightedBgColor ?: [self darkerColor:btn.backgroundColor];
        [btn setBackgroundImage:[self imageWithColor:highlightedBgColor] forState:UIControlStateHighlighted];
    }
    
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
    if (tag.highlightedTextColor) {
        [btn setTitleColor:tag.highlightedTextColor forState:UIControlStateHighlighted];
    }
    if (tag.selectedTextColor) {
        [btn setTitleColor:tag.selectedTextColor forState:UIControlStateSelected];
    }
    if (tag.selectedBgColor) {
        [btn setBackgroundImage:[self imageWithColor:tag.selectedBgColor] forState:UIControlStateSelected];
    }
    
    return btn;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)darkerColor:(UIColor *)color {
    CGFloat h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.85
                               alpha:a];
    return color;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        if (self.tagObj.highlightedBorderColor) {
            self.layer.borderColor = self.tagObj.highlightedBorderColor.CGColor;
        }
    }else{
        self.layer.borderColor = self.tagObj.borderColor.CGColor;
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        if (self.tagObj.selectedBorderColor) {
            self.layer.borderColor = self.tagObj.selectedBorderColor.CGColor;
        }
    } else{
        self.layer.borderColor = self.tagObj.borderColor.CGColor;
    }
}


@end
