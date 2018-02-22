//
// Copyright (c) 2017 Emarsys. All rights reserved.
//

@import Foundation;
@import EmarsysCore;

#import "MEAppLoginParameters.h"
#import "MENotification.h"
#import "MEInAppTrackingProtocol.h"

@protocol MobileEngageStatusDelegate;
@class MEConfig;
@class MENotificationCenterManager;
@class MERequestContext;

typedef void (^MESuccessBlock)(NSString *requestId, EMSResponseModel *);
typedef void (^MEErrorBlock)(NSString *requestId, NSError *error);
typedef void (^MESourceHandler)(NSString *source);

NS_ASSUME_NONNULL_BEGIN

@interface MobileEngageInternal : NSObject <MEInAppTrackingProtocol>

@property(nonatomic, strong) EMSRequestManager *requestManager;
@property(nonatomic, strong) MESuccessBlock successBlock;
@property(nonatomic, strong) MEErrorBlock errorBlock;

@property(nonatomic, weak, nullable) id <MobileEngageStatusDelegate> statusDelegate;
@property(nonatomic, strong) NSData *pushToken;
@property(nonatomic, strong, nullable) MENotificationCenterManager *notificationCenterManager;
@property(nonatomic, strong) MERequestContext *requestContext;

- (BOOL)trackDeepLinkWith:(NSUserActivity *)userActivity
            sourceHandler:(nullable MESourceHandler)sourceHandler;

- (void)setupWithConfig:(MEConfig *)config
          launchOptions:(nullable NSDictionary *)launchOptions;

- (NSString *)appLogin;

- (NSString *)appLoginWithContactFieldId:(nullable NSNumber *)contactFieldId
                       contactFieldValue:(nullable NSString *)contactFieldValue;

- (NSString *)trackMessageOpenWithUserInfo:(NSDictionary *)userInfo;

- (NSString *)trackMessageOpenWithInboxMessage:(MENotification *)inboxMessage;

- (NSString *)trackCustomEvent:(NSString *)eventName
               eventAttributes:(nullable NSDictionary<NSString *, NSString *> *)eventAttributes;

- (NSString *)appLogout;

@end

NS_ASSUME_NONNULL_END
