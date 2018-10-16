//
//  Hooking.h
//  NTKCustomFace
//
//  Created by Michał Kałużny on 13.10.18.
//

#import <objc/runtime.h>

#define Constructor(name) __attribute__((constructor)) static void name()

#define GetClass(className) objc_getClass(#className)

#define NoArguments
#define ArgList(...) ,##__VA_ARGS__

#define HookClassMethod(returnType, className, selector, arglist, replacement) \
do { \
    static returnType (*__orig)(Class self, SEL _cmd arglist); \
    __orig = (void *)method_setImplementation(class_getClassMethod(objc_getClass(#className), selector), \
                                              imp_implementationWithBlock(^(Class self arglist) { \
        __attribute__ ((unused)) SEL _cmd = selector; \
        replacement \
    })); \
} while(0)

#define HookInstanceMethod(returnType, className, selector, arglist, replacement) \
do { \
    static returnType (*__orig)(className *self, SEL _cmd arglist); \
    __orig = (void *)method_setImplementation(class_getInstanceMethod(objc_getClass(#className), selector), \
                                                                      imp_implementationWithBlock(^(className *self arglist) { \
        __attribute__ ((unused)) SEL _cmd = selector; \
        replacement \
    })); \
} while(0)

#define Orig(...) __orig(self, _cmd, ##__VA_ARGS__)

#define GetIvar(obj, name)        object_getIvar(obj, class_getInstanceVariable([obj class], #name))
#define SetIvar(obj, name, value) object_setIvar(obj, class_getInstanceVariable([obj class], #name), value)
