//
//  RecipeNetworking.m
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/20/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import "RecipeNetworking.h"
#import "VGMCollectionViewController.h"

@implementation RecipeNetworking

-(id)initWitURL:(NSString *)url{
//    VGMCollectionViewController *collectionView  = [[VGMCollectionViewController alloc] init];
//    [collectionView setRecipeReference:self];
    // Create the request.
    NSURL *urlString = [[NSURL alloc]initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:urlString completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            // Success
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    NSLog(@"There has been an error parsing the JSON");
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    
                    _recipeData = [[NSMutableDictionary alloc]init];
                    [_recipeData addEntriesFromDictionary:jsonResponse];
                    //[UICollectionView reloadInputViews];
                    NSLog(@"%@",_recipeData);
                    //NSLog(@"FOOD: %@",[_recipeData valueForKey:@"count"]);
                    
                }
            }  else {
                //Web server is returning an error
            }
        } else {
            // Fail
            NSLog(@"error : %@", error.description);
        }
        
        
    }]resume];
    return self;
}

-(NSMutableDictionary *)getJsonArray{
    return _recipeData;
}


@end
