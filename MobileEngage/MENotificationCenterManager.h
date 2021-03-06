//
// Copyright (c) 2018 Emarsys. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^MEHandlerBlock)();

@interface MENotificationCenterManager : NSObject

- (void)addHandlerBlock:(MEHandlerBlock)handlerBlock forNotification:(NSString *)notificationName;

@end