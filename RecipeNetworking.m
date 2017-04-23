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
    NSURL *urlString = [[NSURL alloc]initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:urlString];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:urlString completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            // If call is succesful run this block of code to get recipe data
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    NSLog(@"There has been an error parsing the JSON");
                    
                } else {
                    // Successfully Parsed JSON
                    _mealData = [[NSMutableDictionary alloc]init];
                    [_mealData addEntriesFromDictionary:jsonResponse];
                }
            }  else {
                NSLog(@"Web Service Error Occured");
            }
        } else {
            // An Error occured
            NSLog(@"error : %@", error.description);
        }
        
        
    }]resume];
    return self;
}

-(NSMutableDictionary *)getJsonArray{
    return _mealData;
}


@end
