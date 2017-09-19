//
//  SDLEnvironment.m
//  BeerDiary
//
//  Created by Stephen Lindauer on 8/29/17.
//  Copyright © 2017 Stephen Lindauer. All rights reserved.
//

#import "SDLEnvironment.h"

@implementation SDLEnvironment


+ (NSString *)clientID
{
    NSString *clientID = [[[NSProcessInfo processInfo] environment] objectForKey:@"EnvClientID"];
    if (!clientID) {
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        clientID = infoDict[@"EnvClientID"];
    }
    
    return clientID;
}

+ (NSString *)baseUrl
{
    NSString *baseURL = [[NSProcessInfo processInfo] environment][@"EnvServerBaseURL"];
    if (!baseURL) {
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        baseURL = infoDict[@"EnvServerBaseURL"];
    }
    
    return baseURL;
}


@end
