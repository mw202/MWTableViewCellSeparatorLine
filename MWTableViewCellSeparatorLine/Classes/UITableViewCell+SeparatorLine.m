//
//  UITableViewCell+SeparatorLine.m
//  MWTableViewCellSeparatorLine
//
//  Created by LiY on 2022/3/10.
//

#import "UITableViewCell+SeparatorLine.h"

NSString *const TableViewCellSeparatorLineHidden = @"tableviewcell.separator.line.hidden";
NSString *const TableViewCellSeparatorLineLeft = @"tableviewcell.separator.line.left";
NSString *const TableViewCellSeparatorLineRight = @"tableviewcell.separator.line.right";
NSString *const TableViewCellSeparatorLineHight = @"tableviewcell.separator.line.hight";
NSString *const TableViewCellSeparatorLineColor = @"tableviewcell.separator.line.color";

@implementation UIView (LayoutConstraint)

#pragma mark - NSLayoutConstraint

- (nullable NSLayoutConstraint *)findConstraint:(NSString *)id {
    for (int i = 0; i < self.constraints.count; i++) {
        if (id == self.constraints[i].identifier) {
            return self.constraints[i];
        }
    }
    
    return nil;
}

- (void)updateConstraint:(NSString *)id constraint:(NSLayoutConstraint *)constraint {
    NSLayoutConstraint *c = [self findConstraint:id];
    if (c != nil) {
        [self removeConstraint:c];
        [self addConstraint:constraint];
    }
}

- (void)removeConstraintById:(NSString *)id {
    NSLayoutConstraint *c = [self findConstraint:id];
    if (c != nil) {
        [self removeConstraint:c];
    }
}

- (void)removeConstraintsByIds:(NSArray<NSString *> *)ids {
    for (NSString *id in ids) {
        [self removeConstraintById:id];
    }
}

@end

@implementation UITableViewCell (SeparatorLine)

- (void)setSeparatorLineStyle:(NSDictionary *)style {
    if (self.bounds.size.height <= 0) {
        return;
    }
    
    NSString *idViewAndContentViewLeft = @"cell.view.contentview.left";
    NSString *idViewAndContentViewRight = @"cell.view.contentview.right";
    NSString *idViewAndContentViewBottom = @"cell.view.contentview.bottom";
    NSString *idViewHeight = @"cell.view.height";
    NSInteger separatorViewTag = 2046;
    
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGFLOAT_MAX);
    
    UIView *separatorView = [self viewWithTag:separatorViewTag];
    if (nil == separatorView) {
        separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        separatorView.tag = separatorViewTag;
        [self addSubview:separatorView];
        [self bringSubviewToFront:separatorView];
    }
        
    separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 1.先移除
    [self removeConstraintsByIds:@[idViewAndContentViewLeft,
                                   idViewAndContentViewRight,
                                   idViewAndContentViewBottom]];
    [separatorView removeConstraintById: idViewHeight];
    
    // 约束-left
    NSLayoutConstraint *layoutLeft = [NSLayoutConstraint
                                       constraintWithItem:self
                                       attribute:NSLayoutAttributeLeft
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:separatorView
                                       attribute:NSLayoutAttributeLeft
                                       multiplier:1
                                       constant:-20];
    layoutLeft.identifier = idViewAndContentViewLeft;
    
    // 约束-right
    NSLayoutConstraint *layoutRight = [NSLayoutConstraint
                                       constraintWithItem:self
                                       attribute:NSLayoutAttributeRight
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:separatorView
                                       attribute:NSLayoutAttributeRight
                                       multiplier:1
                                       constant:0];
    layoutRight.identifier = idViewAndContentViewRight;
    
    // 约束-height
    NSLayoutConstraint *layoutHeight = [NSLayoutConstraint
                                        constraintWithItem:separatorView
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1
                                        constant:1];
    layoutHeight.identifier = idViewHeight;
    
    // 约束-bottom
    NSLayoutConstraint *layoutBottom = [NSLayoutConstraint
                                        constraintWithItem:self
                                        attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:separatorView
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1
                                        constant:0];
    layoutBottom.identifier = idViewAndContentViewBottom;
    
    // 2.再添加
    [self addConstraints:@[layoutLeft, layoutRight, layoutBottom]];
    [separatorView addConstraint:layoutHeight];
    
    if (@available(iOS 13.0, *)) {
        separatorView.backgroundColor = UIColor.opaqueSeparatorColor;
    } else {
        // Fallback on earlier versions
        separatorView.backgroundColor = [UIColor colorWithRed:198/255 green:198/255 blue:200/255 alpha:1];
    }
    
    BOOL hidden = [style[TableViewCellSeparatorLineHidden] boolValue];
    id left = style[TableViewCellSeparatorLineLeft];
    id right = style[TableViewCellSeparatorLineRight];
    id height = style[TableViewCellSeparatorLineHight];
    id color = style[TableViewCellSeparatorLineColor];
    
    if (hidden == YES) {
        [separatorView setHidden:YES];
    } else {
        [separatorView setHidden:NO];
        
        if (left != nil) {
            NSLayoutConstraint *viewLeft = [NSLayoutConstraint
                                            constraintWithItem:self
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:separatorView
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1
                                            constant:-[left floatValue]];
            viewLeft.identifier = idViewAndContentViewLeft;
            [self updateConstraint:idViewAndContentViewLeft constraint:viewLeft];
        }
        
        if (right != nil) {
            NSLayoutConstraint *viewRight = [NSLayoutConstraint
                                             constraintWithItem:self
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:separatorView
                                             attribute:NSLayoutAttributeRight
                                             multiplier:1
                                             constant:[right floatValue]];
            viewRight.identifier = idViewAndContentViewRight;
            [self updateConstraint:idViewAndContentViewRight constraint:viewRight];
        }
        
        if (height != nil && height > 0) {
            NSLayoutConstraint *viewHeight = [NSLayoutConstraint
                                              constraintWithItem:separatorView
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1
                                              constant:[height floatValue]];
            viewHeight.identifier = idViewHeight;
            [separatorView updateConstraint:idViewHeight constraint:viewHeight];
        }
        
        if (color != nil) {
            separatorView.backgroundColor = [UIColor colorWithCGColor:[color CGColor]];
        }
    }
}

@end
