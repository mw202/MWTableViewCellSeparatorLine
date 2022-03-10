//
//  UITableViewCell+SeparatorLine.h
//  MWTableViewCellSeparatorLine
//
//  Created by LiY on 2022/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TableViewCellSeparatorLineHidden;
extern NSString *const TableViewCellSeparatorLineLeft;
extern NSString *const TableViewCellSeparatorLineRight;
extern NSString *const TableViewCellSeparatorLineHight;
extern NSString *const TableViewCellSeparatorLineColor;

@interface UIView (LayoutConstraint)

/**
 * 根据id查找约束
 */
- (nullable NSLayoutConstraint *)findConstraint:(NSString *)id;

/**
 * 根据id更新约束
 */
- (void)updateConstraint:(NSString *)id constraint:(NSLayoutConstraint *)constraint;

/**
 * 根据id删除约束
 */
- (void)removeConstraintById:(NSString *)id;

/**
 * 根据id数组删除约束
 */
- (void)removeConstraintsByIds:(NSArray<NSString *> *)ids;

@end

@interface UITableViewCell (SeparatorLine)

- (void)setSeparatorLineStyle:(NSDictionary *)style;

@end

NS_ASSUME_NONNULL_END
