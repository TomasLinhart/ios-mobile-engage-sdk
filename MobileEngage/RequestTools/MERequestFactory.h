//
// Copyright (c) 2018 Emarsys. All rights reserved.
//

@import Foundation;
@import EmarsysCore;

@class MERequestContext;
@class MENotification;


@interface MERequestFactory : NSObject

+ (EMSRequestModel *)createLoginRequestWithPushToken:(NSData *)pushToken
                                      requestContext:(MERequestContext *)requestContext;

+ (EMSRequestModel *)createAppLogoutRequestWithRequestContext:(MERequestContext *)requestContext;

+ (EMSRequestModel *)createTrackMessageOpenRequestWithNotification:(MENotification *)inboxMessage
                                                    requestContext:(MERequestContext *)requestContext;

+ (EMSRequestModel *)createTrackMessageOpenRequestWithMessageId:(NSString *)messageId
                                                 requestContext:(MERequestContext *)requestContext;

+ (EMSRequestModel *)createTrackCustomEventRequestWithEventName:(NSString *)eventName
                                                eventAttributes:(NSDictionary<NSString *, NSString *> *)eventAttributes
                                                 requestContext:(MERequestContext *)requestContext;

+ (EMSRequestModel *)createCustomEventModelWithEventName:(NSString *)eventName
                                         eventAttributes:(NSDictionary<NSString *, NSString *> *)eventAttributes
                                                    type:(NSString *)type
                                          requestContext:(MERequestContext *)requestContext;

@end
