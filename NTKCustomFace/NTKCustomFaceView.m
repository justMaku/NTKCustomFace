//
//  NTKCustomFaceView.m
//  NTKCustomFace
//
//  Created by Michał Kałużny on 13.10.18.
//

@import SceneKit;
@import WatchKit;

#import "NTKCustomFaceView.h"

@interface NTKCustomFaceView ()

@property (weak, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation NTKCustomFaceView

- (id)init
{
    self = [super init];
    
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        self.textLabel = label;
        
        [self setupUI];
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"hh:mm:ss";
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    return self;
}

- (void)setupUI
{
    self.textLabel.text = @"¯\\_(ツ)_/¯";
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = UIColor.blackColor;
    self.textLabel.numberOfLines = 0;
    
    self.backgroundColor = UIColor.whiteColor;
}

- (void)tick
{
    NSString *dateText = [NSString stringWithFormat:@"¯\\_(ツ)_/¯\n%@", [self.dateFormatter stringFromDate:[NSDate date]]];
    self.textLabel.text = dateText;
}

- (void)layoutSubviews {
    self.textLabel.frame = self.bounds;
}

- (NTKFaceStyle)faceStyle {
    return NTKFaceStyleCustom;
}

@end
