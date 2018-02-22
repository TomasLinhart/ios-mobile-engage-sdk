//
// Copyright (c) 2017 Emarsys. All rights reserved.
//

@import Foundation;
@import EmarsysCore;

#import "MEDefaultHeaders.h"
#import "MEConfig.h"
#import "MobileEngageVersion.h"

@implementation MEDefaultHeaders

+ (NSDictionary *)additionalHeadersWithConfig:(MEConfig *)config {
    return @{@"Content-Type": @"application/json",
            @"X-MOBILEENGAGE-SDK-VERSION": MOBILEENGAGE_SDK_VERSION,
#if DEBUG
            @"X-MOBILEENGAGE-SDK-MODE": @"debug"
#else
            @"X-MOBILEENGAGE-SDK-MODE" : @"production"
#endif
    };
}

@end
