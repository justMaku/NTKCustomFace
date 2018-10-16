# NTKCustomFace

>Your scientists were so preoccupied with whether or not they could, they didn’t stop to think if they should.
>
> <cite>Jeff Goldblum</cite>

This project is a result of a weekend long research into the inner workings of `NanoTimeKit` framework and `Carousel` process inspired by [@steventroughtonsmith](https://github.com/steventroughtonsmith) work on his [SpriteKitWatchFace](https://github.com/steventroughtonsmith/SpriteKitWatchFace) project.

It is heavily based on a similar (but outdated) [project](https://github.com/hamzasood/CustomWatchFaceTest) by [@hamzasood](https://github.com/hamzasood).

# How Does this work?

By hijacking the `_addableFaceCollection` property of the `NTKFaceLibraryViewController` we are able to directly modify the dictionary to also include our custom subclass of the `NTKFace`.

This adds the custom face to the list of available ones, and then by swizzling the `loadView` on the `NTKFaceViewController` we can replace the standard view with our custom one.

This is obviously nowhere close to how the API should be used and further research is needed to fully understand the process.

# Setup:

Before you will be able to compile the project you will have to move 2 private frameworks from the watchOS Simulator to the `Private Frameworks` directory.

Frameworks in questions are: `NanoTimeKit` and `RelevanceEngine`, you can find them inside Xcode bundle:

`/Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/watchOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/`

The project also depends on a watchOS Simulator with a name `Apple Watch Series 4 - 44mm` being present. This is the standard name that Xcode uses, but if you have renamed your simulated devices, you will have to modify the `launcher.sh` file (look for the `SIMULATOR_NAME` constant).

# Running:

In the ideal world all you should have to do is open Xcode project and hit `⌘+R`. This should compile the project, boot up the watchOS Simulator, restart the `Carousel` process and in the end inject the compiled library using some `lldb` magic.

# Limitations:

* Currently all of the `NanoTimeKit` and `UIKit` are forward declared in the `NanoTimeKit.h` file. This is not the ideal solution, so another way of importing those headers needs to be found.
* Since we're compiling an library, assets like images are not properly supported.
* This obviously doesn't work on actual hardware.

# Further research:

* Support for customization through official UI
* Support for complications
* Proper way of injecting the watch faces instead of directly modyfing the presenation model.
* Better way of linking with `NanoTimeKit` and `UIKit` so all classes are available for use.
