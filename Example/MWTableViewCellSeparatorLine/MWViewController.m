//
//  MWViewController.m
//  MWTableViewCellSeparatorLine
//
//  Created by LiY on 03/10/2022.
//  Copyright (c) 2022 LiY. All rights reserved.
//

#import "MWViewController.h"

@interface MWViewController ()

@end

@implementation MWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            [cell setSeparatorLineStyle:@{TableViewCellSeparatorLineLeft: @30}];
            break;
        case 1:
            [cell setSeparatorLineStyle:@{TableViewCellSeparatorLineLeft: @30, TableViewCellSeparatorLineRight: @50}];
            break;
        case 2:
            [cell setSeparatorLineStyle:@{TableViewCellSeparatorLineHight: @8}];
            break;
        case 3:
            [cell setSeparatorLineStyle:@{TableViewCellSeparatorLineHidden: @YES}];
            break;
        case 4:
            [cell setSeparatorLineStyle:@{TableViewCellSeparatorLineColor: UIColor.purpleColor}];
            break;
        case 5:
            [cell setSeparatorLineStyle:@{TableViewCellSeparatorLineColor: UIColor.redColor, TableViewCellSeparatorLineLeft: @0}];
            break;
        default: break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

@end
