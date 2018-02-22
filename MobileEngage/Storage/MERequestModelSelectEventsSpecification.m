//
// Copyright (c) 2018 Emarsys. All rights reserved.
//

@import Foundation;
@import EmarsysCore;

#import "MERequestModelSelectEventsSpecification.h"

@implementation MERequestModelSelectEventsSpecification


- (NSString *)sql {
    return [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE '%%/v3/devices/_%%/events';", TABLE_NAME, COLUMN_NAME_URL];
}

- (void)bindStatement:(sqlite3_stmt *)statement {
}

@end
