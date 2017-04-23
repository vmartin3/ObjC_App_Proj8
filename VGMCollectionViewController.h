//
//  VGMCollectionViewController.h
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/20/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeNetworking.h"
#import "RecipeViewController.h"

@interface VGMCollectionViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
   // @property (nonatomic, retain) RecipeNetworking *recipeReference;
    @property(nonatomic, retain) NSMutableDictionary *allRecipeData;
    @property(nonatomic, retain) NSString *recipeImages;
    @property(nonatomic, retain) NSString *recipeStringValue;
    @property(nonatomic, retain) NSMutableArray *recipeID;

@end
