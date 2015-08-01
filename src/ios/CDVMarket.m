//
//  CDVMarket.h
//
// Created by Miguel Revetria miguel@xmartlabs.com on 2014-03-17.
// License Apache 2.0

#include "CDVMarket.h"

#import <StoreKit/SKStoreProductViewController.h>



@implementation CDVMarket

- (void)pluginInitialize
{
}

- (void)open:(CDVInvokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    NSString *appId = [args objectAtIndex:0];
    appId = [appId substringFromIndex: 2];

    [self.commandDelegate runInBackground:^{

    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

        
    SKStoreProductViewController* spvc = [[SKStoreProductViewController alloc] init];
        spvc.delegate = self;
    [spvc loadProductWithParameters:
            @{SKStoreProductParameterITunesItemIdentifier : appId}
                    completionBlock:nil];
    
    [topController presentViewController:spvc animated:YES completion:nil];

    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        
    }];
}

# pragma mark - SKStoreProductViewController delegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [self.viewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
