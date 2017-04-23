//
//  RecipeViewController.h
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/22/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeNetworking.h"

@interface RecipeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UILabel *recipeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImage;
@property(copy, nonatomic) NSMutableDictionary *recipeItem;
@end
