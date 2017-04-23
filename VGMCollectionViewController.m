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
    _recipeID = [[NSMutableArray alloc]initWithCapacity:_allRecipeData.count];
    static dispatch_once_t once;
    dispatch_once(&once, ^{
    networkReference = [[RecipeNetworking alloc]initWitURL:@"http://food2fork.com/api/search?key=ff64d2b133c5b0fe9d9f9489538ba76f&q=shredded%20chicken"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        _allRecipeData=[networkReference getJsonArray];
        [self.collectionView reloadData];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)segue: (id)sender
{
    [self getRecipe:_recipeStringValue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
       [self performSegueWithIdentifier:@"Detail" sender:self];
    });
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //RecipeViewController *myDestinationViewController = [segue destinationViewController];
    RecipeViewController *myDestinationViewController = [(UINavigationController*)segue.destinationViewController topViewController];
    //NSLog(@"%@", [networkReference getJsonArray]);
    
    //MARK: ERROR IS HERE FIX
    myDestinationViewController.recipeItem = [[NSMutableArray alloc]initWithObjects:[networkReference getJsonArray], nil];
}

-(void)getRecipe: (NSString *)recipeID {
   NSLog(@"%@", [_recipeID description]);
        NSString *urlString = [NSString stringWithFormat:@"http://food2fork.com/api/get?key=ff64d2b133c5b0fe9d9f9489538ba76f&rId=%@",recipeID];
        //NSLog(@"%@", urlString);
    networkReference = [[RecipeNetworking alloc]initWitURL:urlString];
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
        
    NSData *foodPciture =[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[_allRecipeData valueForKey:@"recipes"]objectAtIndex:indexPath.row]valueForKey:@"image_url"]]];
        cell.foodImage.image = [UIImage imageWithData:foodPciture];
        cell.foodTitle.text = [[[_allRecipeData valueForKey:@"recipes"]objectAtIndex:indexPath.row]valueForKey:@"title"];
    });

    [_recipeID addObject:[[[_allRecipeData valueForKey:@"recipes"]objectAtIndex:indexPath.row]valueForKey:@"recipe_id"]];
    _recipeStringValue = [_recipeID objectAtIndex:indexPath.row];
    cell.foodImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segue:)];
    tapped.numberOfTapsRequired = 1;
    [cell.foodImage addGestureRecognizer:tapped];
    
     return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ROW SELECTED");
    
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
