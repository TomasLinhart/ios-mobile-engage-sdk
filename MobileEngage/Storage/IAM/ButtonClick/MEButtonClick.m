//
//  Copyright © 2018 Emarsys. All rights reserved.
//

@import Foundation;
@import EmarsysCore;

#import "MEButtonClick.h"

@implementation MEButtonClick

- (instancetype)initWithCampaignId:(NSString *)campaignId
                          buttonId:(NSString *)buttonId
                         timestamp:(NSDate *)timestamp {
    if (self = [super init]) {
        self.campaignId = campaignId;
        self.buttonId = buttonId;
        self.timestamp = timestamp;
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToClick:other];
}

- (BOOL)isEqualToClick:(MEButtonClick *)click {
    if (self == click)
        return YES;
    if (click == nil)
        return NO;
    if (self.campaignId != click.campaignId && ![self.campaignId isEqualToString:click.campaignId])
        return NO;
    if (self.buttonId != click.buttonId && ![self.buttonId isEqualToString:click.buttonId])
        return NO;
    if (self.timestamp != click.timestamp && [self.timestamp timeIntervalSince1970] != [click.timestamp timeIntervalSince1970])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.campaignId hash];
    hash = hash * 31u + [self.buttonId hash];
    hash = hash * 31u + [self.timestamp hash];
    return hash;
}

- (NSDictionary *)dictionaryRepresentation {
    return @{
            @"message_id" : self.campaignId,
            @"button_id" : self.buttonId,
            @"timestamp" : [EMSTimestampProvider utcFormattedStringFromDate:self.timestamp]
    };
}

@end
