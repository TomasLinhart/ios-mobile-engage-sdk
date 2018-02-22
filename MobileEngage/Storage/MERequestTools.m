//
// Copyright (c) 2018 Emarsys. All rights reserved.
//

@import Foundation;
@import EmarsysCore;

#import "MERequestTools.h"

@implementation MERequestTools

+ (BOOL)isRequestCustomEvent:(EMSRequestModel *)request {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@".*/v3/devices/\\w+/events$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *url = [request.url absoluteString];
    return url && [regex numberOfMatchesInString:url options:0 range:NSMakeRange(0, [url length])] > 0;
}

@end
