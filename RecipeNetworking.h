//
//  RecipeNetworking.h
//  ObjC_Project8
//
//  Created by Vernon G Martin on 4/20/17.
//  Copyright © 2017 Vernon G Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeNetworking : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
-(id)initWitURL:(NSString*) url;
@property(nonatomic, retain) NSMutableDictionary *recipeData;
@end
