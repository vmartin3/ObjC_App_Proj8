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
    @property(nonatomic, retain) NSMutableDictionary *recipeDetails;
    @property(nonatomic, retain) NSMutableArray *recipeIDs;
@end
