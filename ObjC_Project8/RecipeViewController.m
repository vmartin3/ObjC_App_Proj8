//
//  RecipeViewController.m
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/22/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeNetworking.h"


@interface RecipeViewController ()

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //MARK: - Recipe Details VC Setup
    _recipeTitle.text = [[_recipeItem valueForKeyPath:@"recipe.title"]objectAtIndex:0 ];
    NSURL *url = [NSURL URLWithString:[[_recipeItem valueForKeyPath:@"recipe.image_url"]objectAtIndex:0]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _recipeImage.image = [UIImage imageWithData:data];
    [self roundImage];
}

-(void)roundImage{
    [self.view layoutIfNeeded];
    self.recipeImage.layer.cornerRadius = 60;
    self.recipeImage.clipsToBounds = YES;
    self.recipeImage.layer.borderWidth = 5.0f;
    self.recipeImage.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows in the ingredients table
    return [[[_recipeItem valueForKeyPath:@"recipe.ingredients"] objectAtIndex:0] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"RecipeLine";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier]];
    }
    cell.textLabel.text = [[[_recipeItem valueForKeyPath:@"recipe.ingredients"] objectAtIndex:0] objectAtIndex:indexPath.row];
    return cell;
}

@end
