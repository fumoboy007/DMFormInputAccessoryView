DMFormInputAccessoryView
========================

What it does
------------

DMFormInputAccessoryView provides an input accessory view for `UITextField`s (or other `UIResponder`s) that coordinates a data source and a toolbar with Previous/Next and Done buttons.

Here's what it looks like by default:  
![Screenshot of toolbar with Previous/Next and Done buttons](README/toolbarScreenshot.png)

How to use it
-------------

The interface is very simple. You need to implement the `DMFormInputAccessoryViewDataSource` protocol in one of your classes (say your view controller). To configure the input accessory view, you set the `dataSource` property to your data source and the `attachedResponder` property to your `UIResponder` (your text field or whatever). When something changes that modifies the enabled state of the buttons, you call `reloadData`.

To include it in your project, you can just take the `DMFormInputAccessoryView.h` and `DMFormInputAccessoryView.m` files and drop them into your project. Alternatively, you can embed this project as a subproject and add `$(CONFIGURATION_BUILD_DIR)` and `"$(BUILD_ROOT)/../IntermediateBuildFilesPath/UninstalledProducts"` to your `Header Search Paths` build setting.

License
-------

Licensed under the MIT license.