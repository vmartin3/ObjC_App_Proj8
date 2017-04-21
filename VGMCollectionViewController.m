//
//  VGMCollectionViewController.m
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/20/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import "VGMCollectionViewController.h"
#import "VGMCollectionViewCell.h"

RecipeNetworking *networkCall;
@interface VGMCollectionViewController ()

@end

@implementation VGMCollectionViewController


- (void)viewDidLoad {
//    UITapGestureRecognizer *singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(handleSingleTap:)];
//    [self.view addGestureRecognizer:singleFingerTap];
    networkCall = [[RecipeNetworking alloc]initWitURL:@"http://food2fork.com/api/search?key=ff64d2b133c5b0fe9d9f9489538ba76f&q=shredded%20chicken"];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 100 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.collectionView.backgroundColor = [UIColor whiteColor];
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Tapped");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VGMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //NSLog(@"FOOD: %@",[self.recipeReference.recipeData valueForKey:@"recipe"]);
    UIImage *btnImage = [UIImage imageWithContentsOfFile:[self.recipeReference.recipeData valueForKey:@"recipes.imageurl"]];
    
    [cell.foodButton setImage:btnImage forState:UIControlStateNormal];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"RecipeDetails" sender:self];
}

@end
