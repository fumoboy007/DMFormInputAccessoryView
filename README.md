DMFormInputAccessoryView
========================

What it does
------------

DMFormInputAccessoryView provides an input accessory view for a `UITextField` (or any `UIResponder`) that coordinates a data source and a toolbar with Previous/Next and Done buttons.

Here's what it looks like in iOS 6.1 and below:  
![Screenshot of toolbar with Previous/Next and Done buttons - iOS 6.1 and below](README/toolbarScreenshot.png)

And here's what is looks like on iOS 7 and above:
![Screenshot of toolbar with Previous/Next and Done buttons - iOS 7 and above](README/toolbarScreenshot-iOS7.png)

How to use it
-------------

The interface is very simple. You implement the `DMFormInputAccessoryViewDataSource` protocol in one of your classes (say your view controller class). To configure the input accessory view, you set the `dataSource` property to your data source and the `attachedResponder` property to your `UIResponder` (your text field or whatever). When something changes that modifies the enabled state of the buttons, you call `reloadData`. I also added a convenience category for `UIResponder` so that you don't have to cast every time. =)

To include it in your project, you can just take the `DMFormInputAccessoryView.h`/`DMFormInputAccessoryView.m` files (and `UIResponder+DMFormInputAccessoryView.h`/`UIResponder+DMFormInputAccessoryView.m` if you want) and drop them into your project. Alternatively, you can embed this project as a subproject and add `$(CONFIGURATION_BUILD_DIR)` and `"$(BUILD_ROOT)/../IntermediateBuildFilesPath/UninstalledProducts"` to your `Header Search Paths` build setting. You will also need `-ObjC` in `Other Linker Flags`.

License
-------

Licensed under the MIT license.