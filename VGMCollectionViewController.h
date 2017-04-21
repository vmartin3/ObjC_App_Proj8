//
//  VGMCollectionViewController.h
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/20/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeNetworking.h"

@interface VGMCollectionViewController : UICollectionViewController
    @property (nonatomic, retain) RecipeNetworking *recipeReference;
@end
