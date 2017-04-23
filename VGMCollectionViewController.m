//
//  VGMCollectionViewController.m
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/20/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import "VGMCollectionViewController.h"
#import "VGMCollectionViewCell.h"

RecipeNetworking *recipeDataNetworkCall;
@interface VGMCollectionViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@end

@implementation VGMCollectionViewController


- (void)viewDidLoad {
    _recipeIDs = [[NSMutableArray alloc]initWithCapacity:_recipeDetails.count];
    _recipeDetails = [[NSMutableDictionary alloc]init];
    
    //MARK: - Fetch Meal Data
    //Fetch All Recipe Data Once when View First Loads
    static dispatch_once_t once;
    dispatch_once(&once, ^{
    recipeDataNetworkCall = [[RecipeNetworking alloc]initWitURL:@"http://food2fork.com/api/search?key=ff64d2b133c5b0fe9d9f9489538ba76f&q=shredded%20chicken"];
    });
    
    //Assign Recipe Data to a local variable and reload table with the new information after request call is completed
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        _recipeDetails=[recipeDataNetworkCall getJsonArray];
        [self.collectionView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //MARK: - Prep next View Controller
    //Passing Recipe Details for Selected Meal to the RecipeViewController
    RecipeViewController *recipeDetailsVC = [(UINavigationController*)segue.destinationViewController topViewController];
    recipeDetailsVC.recipeItem = [[NSMutableArray alloc]initWithObjects:[recipeDataNetworkCall getJsonArray], nil];
}

-(void)getRecipe: (NSString *)recipeID {
    //MARK: - Fetch Recipe Details
    //Making an API Network call to get recipe details for specific meal the user selects based on recipeID
        NSString *urlString = [NSString stringWithFormat:@"http://food2fork.com/api/get?key=ff64d2b133c5b0fe9d9f9489538ba76f&rId=%@",recipeID];
   recipeDataNetworkCall = [[RecipeNetworking alloc]initWitURL:urlString];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //Returns the number of cells needed based on the number of recipes returned by the API call
    return [[_recipeDetails valueForKey:@"count"] integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VGMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    //MARK: - Populating Cells
    //Updating UI to show the food cells with their respective images and titles on the main page
    dispatch_async(dispatch_get_main_queue(), ^{
    NSData *foodPciture =[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[_recipeDetails valueForKey:@"recipes"]objectAtIndex:indexPath.row]valueForKey:@"image_url"]]];
        cell.foodImage.image = [UIImage imageWithData:foodPciture];
        cell.foodTitle.text = [[[_recipeDetails valueForKey:@"recipes"]objectAtIndex:indexPath.row]valueForKey:@"title"];
    });

    //Parses recipe details for that meal and stores that recipe ID in a sepearte array
    [_recipeIDs addObject:[[[_recipeDetails valueForKey:@"recipes"]objectAtIndex:indexPath.row]valueForKey:@"recipe_id"]];
    
    //MARK: - UITap Gesture Setup
    cell.foodImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] init];
    tapped.numberOfTapsRequired = 1;
    tapped.cancelsTouchesInView = NO;
    [cell.foodImage addGestureRecognizer:tapped];
    
     return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self getRecipe:[_recipeIDs objectAtIndex:indexPath.row]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"Detail" sender:self];
    });

}

//Sets up 3 columns of cells with no space between for the collection view
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 3.0;
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    
    return size;
}


@end
