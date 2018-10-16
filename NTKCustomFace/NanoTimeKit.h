
@import UIKit;

typedef enum : NSUInteger {
    NTKFaceStyleCustom = 0xBAD1DEA
} NTKFaceStyle;

@interface UIView: NSObject

@property (readwrite, nonatomic) UIColor *backgroundColor;
@property (readwrite, nonatomic) CGRect frame;
@property (readwrite, nonatomic) CGRect bounds;

- (void)addSubview:(UIView *)subview;
- (void)removeFromSuperview;

@end

@interface UILabel: UIView

@property (readwrite, nonatomic) NSString *text;
@property (readwrite, nonatomic) NSTextAlignment textAlignment;
@property (readwrite, nonatomic) UIColor *textColor;
@property (readwrite, nonatomic) NSInteger numberOfLines;


@end

@interface UIViewController: NSObject

@property (readwrite, nonatomic) UIView *view;

- (NSArray<UIViewController *> *)childViewControllers;

@end

@interface UIWindow : NSObject

@property (readwrite, nonatomic) UIViewController* rootViewController;

+ (UIWindow *)keyWindow;

@end

@interface NTKFace : NSObject

@property (readwrite, nonatomic) BOOL isEditable;
@property (readwrite, nonatomic) NTKFaceStyle faceStyle;
@property (readwrite, nonatomic) NSString *name;

@end

@interface NTKFaceView: UIView

@property (readwrite, nonatomic) NTKFaceStyle faceStyle;

@end

@interface NTKDigitalFaceView: NTKFaceView

@end

@interface NTKFaceCollection: NSObject

- (NSDictionary<NSUUID *, NTKFace *> *)facesByUUID;

@end

@interface NTKFaceViewController : UIViewController

@property (readonly, nonatomic) NTKFace *face;
@property (readonly, nonatomic) NTKFaceView *faceView;

@end

@interface NTKPersistentFaceCollection: NSObject

- (void)_addFace:(NTKFace *)face forUUID:(NSUUID *)uuid atIndex:(unsigned int)index;

@end

@interface NTKFaceLibraryViewController: UIViewController
@end
