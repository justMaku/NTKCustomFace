//
//  NTKCustomFace.m
//  NTKCustomFace
//
//  Created by Michał Kałużny on 13.10.18.
//

#import "NTKCustomFace.h"

@implementation NTKCustomFace

- (NSString *)name {
    return @"My Custom Face";
}

- (NTKFaceStyle)faceStyle {
    return NTKFaceStyleCustom;
}

+ (NSUUID *)uuid
{
    static dispatch_once_t once;
    static NSUUID *uuid;
    dispatch_once(&once, ^{
        uuid = [NSUUID UUID];
    });
    
    return uuid;
}

@end
