//
//  SupportingHooks.m
//  NTKCustomFace
//
//  Created by Michał Kałużny on 13.10.18.
//

#import <os/log.h>

#import "Hooking.h"

#import "NanoTimeKit.h"

#import "NTKCustomFace.h"
#import "NTKCustomFaceView.h"


UIViewController* findViewController(UIViewController *parent, Class klass) {
    for (UIViewController *vc in [parent childViewControllers]) {
        if ([vc isMemberOfClass:klass]) {
            return vc;
        }
            
        UIViewController* child = findViewController(vc, klass);
        
        if (child != nil) {
            return child;
        }
    }
            
    return nil;
}

static NTKFace* face;

Constructor(SupportingHooksInit) {
    os_log(OS_LOG_DEFAULT, "CSTM: Magic starts here.");
    
    UIViewController* rootViewController = [[UIWindow keyWindow] rootViewController];
    NTKFaceLibraryViewController* faceCollectionVC = findViewController(rootViewController, [NTKFaceLibraryViewController class]);
    
    if (faceCollectionVC == nil) {
        os_log(OS_LOG_DEFAULT, "CSTM: Unable to find collection VC.");

        return;
    }
    
    os_log(OS_LOG_DEFAULT, "CSTM: Found collection VC at %@.", faceCollectionVC);
    face = [[NTKCustomFace alloc] init];
    
    NTKPersistentFaceCollection *faceCollection = GetIvar(faceCollectionVC, _addableFaceCollection);
    os_log(OS_LOG_DEFAULT, "CSTM: Will insert to the library: %@.", faceCollection);

    [faceCollection _addFace:face forUUID:[NTKCustomFace uuid] atIndex:0];
    
    os_log(OS_LOG_DEFAULT, "CSTM: Inserted our face to the library.");
    
    /* 
     Hook +[NTKFace _faceClassForStyle:] to return our custom face class when needed.
    */
    HookClassMethod(Class, NTKFace, @selector(_faceClassForStyle:), ArgList(NTKFaceStyle faceStyle), {
        os_log(OS_LOG_DEFAULT, "CSTM: Requested our face!.");

        return (faceStyle == NTKFaceStyleCustom ? [NTKCustomFace class] : Orig(faceStyle));
    });
    
    /* 
     Hook -[NTKFaceViewController loadView] to create our custom NTKFaceView subclass when needed.
    */
    HookInstanceMethod(void, NTKFaceViewController, @selector(loadView), NoArguments, {
        Orig();
        
        if (self.face.faceStyle == NTKFaceStyleCustom) {
            os_log(OS_LOG_DEFAULT, "CSTM: Loading our face!.");

            [self.faceView removeFromSuperview];
            SetIvar(self, _faceView, nil);
            
            NTKCustomFaceView *customFaceView = [[NTKCustomFaceView alloc] init];
            
            os_log(OS_LOG_DEFAULT, "CSTM: Frame set to: \(%@).", NSStringFromCGRect(customFaceView.frame));

            [self.view addSubview:customFaceView];
            self.view.backgroundColor = UIColor.redColor;
            SetIvar(self, _faceView, customFaceView);
        }
    });
}
