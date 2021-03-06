#import "Kiwi.h"
#import "MEIAMOpenExternalLink.h"
#import "MEOsVersionUtils.h"

SPEC_BEGIN(MEIAMOpenExternalLinkTests)

    __block UIApplication *_applicationMock;
    __block MEIAMOpenExternalLink *_command;

    describe(@"openExternalLink", ^{

        beforeEach(^{
            _command = [MEIAMOpenExternalLink new];
            _applicationMock = [UIApplication mock];
            [[UIApplication should] receive:@selector(sharedApplication) andReturn:_applicationMock];
        });

        it(@"should return false if link is not valid", ^{
            NSString *link = @"notAValidUrl";

            [[_applicationMock should] receive:@selector(canOpenURL:) andReturn:theValue(NO)];
            XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"wait"];

            __block BOOL returnedContent;
            [_command handleMessage:@{@"id": @1, @"url": link}
                        resultBlock:^(NSDictionary<NSString *, NSObject *> *result) {
                            returnedContent = [((NSNumber *) result[@"success"]) boolValue];
                            [exp fulfill];
                        }];

            [XCTWaiter waitForExpectations:@[exp]
                                   timeout:30];

            [[theValue(returnedContent) should] beNo];
        });

        it(@"should return false if there is no url", ^{
            XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"waitForResult"];
            __block NSDictionary<NSString *, NSObject *> *returnedResult;

            [_command handleMessage:@{@"id": @"999"}
                        resultBlock:^(NSDictionary<NSString *, NSObject *> *result) {
                            returnedResult = result;
                            [exp fulfill];
                        }];
            [XCTWaiter waitForExpectations:@[exp] timeout:30];

            [[returnedResult should] equal:@{@"success": @NO, @"id": @"999", @"error": @"Missing url!"}];

        });

        if (SYSTEM_VERSION_LESS_THAN(@"10.0")) {
            it(@"should open the link if it is valid below ios10", ^{
                NSString *link = @"https://www.google.com";

                _applicationMock = [UIApplication mock];
                [[UIApplication should] receive:@selector(sharedApplication) andReturn:_applicationMock];

                [[_applicationMock should] receive:@selector(canOpenURL:) andReturn:theValue(YES)];
                [[_applicationMock should] receive:@selector(openURL:) withArguments:[NSURL URLWithString:link]];

                [_command handleMessage:@{@"url": link, @"id": @1}
                            resultBlock:^(NSDictionary<NSString *, NSObject *> *result) {
                            }];
            });

            void (^testCompletionHandlerWithReturnValue)(BOOL returnValue) = ^void(BOOL expectedValue) {
                NSString *link = @"https://www.google.com";

                _applicationMock = [UIApplication mock];
                [[UIApplication should] receive:@selector(sharedApplication) andReturn:_applicationMock];

                [[_applicationMock should] receive:@selector(canOpenURL:) andReturn:theValue(YES)];
                [[_applicationMock should] receive:@selector(openURL:) andReturn:theValue(expectedValue)];

                XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"wait"];
                __block BOOL returnedValue;

                [_command handleMessage:@{@"id": @"123", @"url": link}
                            resultBlock:^(NSDictionary<NSString *, NSObject *> *result) {
                                returnedValue = [((NSNumber *) result[@"success"]) boolValue];
                                [exp fulfill];
                            }];

                [XCTWaiter waitForExpectations:@[exp]
                                       timeout:30];

                [[theValue(returnedValue) should] equal:theValue(expectedValue)];
            };


            it(@"should call completion handler with YES in openURL completionHandler below ios10", ^{
                testCompletionHandlerWithReturnValue(YES);
            });

            it(@"should call completion handler with NO in openURL completionHandler below ios10", ^{
                testCompletionHandlerWithReturnValue(NO);
            });
        }

        if (!SYSTEM_VERSION_LESS_THAN(@"10.0")) {
            it(@"should open the link if it is valid above ios10", ^{
                NSString *link = @"https://www.google.com";

                _applicationMock = [UIApplication mock];
                [[UIApplication should] receive:@selector(sharedApplication) andReturn:_applicationMock];

                [[_applicationMock should] receive:@selector(canOpenURL:) andReturn:theValue(YES)];
                [[_applicationMock should] receive:@selector(openURL:options:completionHandler:) withArguments:[NSURL URLWithString:link], nil, kw_any()];

                [_command handleMessage:@{@"url": link, @"id": @1}
                            resultBlock:^(NSDictionary<NSString *, NSObject *> *result) {
                            }];
            });

            void (^testCompletionHandlerWithReturnValue)(BOOL returnValue) = ^void(BOOL expectedValue) {
                NSString *link = @"https://www.google.com";

                _applicationMock = [UIApplication mock];
                [[UIApplication should] receive:@selector(sharedApplication) andReturn:_applicationMock];

                [[_applicationMock should] receive:@selector(canOpenURL:) andReturn:theValue(YES)];
                [[_applicationMock should] receive:@selector(openURL:options:completionHandler:)];
                KWCaptureSpy *spy = [_applicationMock captureArgument:@selector(openURL:options:completionHandler:)
                                                              atIndex:2];

                XCTestExpectation *exp = [[XCTestExpectation alloc] initWithDescription:@"wait"];
                __block BOOL returnedValue;
                [_command handleMessage:@{@"url": link, @"id": @1}
                            resultBlock:^(NSDictionary<NSString *, NSObject *> *result) {
                                returnedValue = [((NSNumber *) result[@"success"]) boolValue];
                                [exp fulfill];
                            }];

                void (^completionBlock)(BOOL success) = spy.argument;
                completionBlock(expectedValue);

                [XCTWaiter waitForExpectations:@[exp]
                                       timeout:30];

                [[theValue(returnedValue) should] equal:theValue(expectedValue)];
            };

            it(@"should call completion handler with YES in openURL completionHandler above ios10", ^{
                testCompletionHandlerWithReturnValue(YES);
            });

            it(@"should call completion handler with NO in openURL completionHandler above ios10", ^{
                testCompletionHandlerWithReturnValue(NO);
            });

        }

    });

SPEC_END



