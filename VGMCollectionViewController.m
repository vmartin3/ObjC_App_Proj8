//
//  VGMCollectionViewController.m
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/20/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import "VGMCollectionViewController.h"
#import "VGMCollectionViewCell.h"

RecipeNetworking *networkReference;
@interface VGMCollectionViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@end

@implementation VGMCollectionViewController


- (void)viewDidLoad {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
    networkReference = [[RecipeNetworking alloc]initWitURL:@"http://food2fork.com/api/search?key=ff64d2b133c5b0fe9d9f9489538ba76f&q=shredded%20chicken"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        _allRecipeData=[networkReference getJsonArray];
        [self.collectionView reloadData];
    });

    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[_allRecipeData valueForKey:@"count"] integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VGMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    UIImage *btnImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[_allRecipeData valueForKey:@"recipes"]objectAtIndex:indexPath.row]valueForKey:@"image_url"]]]];
        

    [cell.foodButton setImage:btnImage forState:UIControlStateNormal];
        
    });
     return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"RecipeDetails" sender:self];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 3.0; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    
    return size;
}


@end
