//
//  BDGenericTextCell.h
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/16/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDGenericTextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryLabel;

@end
