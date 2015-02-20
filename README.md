# KMHorizontalButtonsView

Dynamically fill a subclassed UIView with rounded-corner UIButtons based off of an array of strings. This class also sequentially animates the adding and removing of buttons for a nice UI touch.

<p align="center">
  <img align="center" src="https://raw.github.com/bennyguitar/iOS----BubbleButtonView/master/BubbleButtonView/screenshot-01.png" alt="...">
</p>

## Current Version

Version: 0.0.1

## How to install it?

[CocoaPods](http://cocoapods.org) is the easiest way to install KMAccordionTableViewController. Run ```pod search KMHorizontalButtonsView``` to search for the latest version. Then, copy and paste the ```pod``` line to your ```Podfile```. Your podfile should look like:

```
platform :ios, '6.0'
pod 'KMHorizontalButtonsView'
```

Finally, install it by running ```pod install```.

If you don't use CocoaPods, import the all files from "Classes" directory to your project.

## How to use it?

BBView works by taking an array of NSStrings and creating a UIButton for each one. The buttons are systematically added to the View such that they will fit on the line next to the last one, or if it won't fit, added on a new line. Because BBView's animations work via subviews (each UIButton is a subview of BBView), you should make BBView the lowest level possible - don't add more UI elements to BBView. Keep it simple.

Begin by making a new UIView in your ViewController.xib, and changing its class to BBView (through the identity inspector in the right bar). Drag this over to your ViewController.h to connect it up. In your .h

```objc
@interface ViewController : UIViewController <BBDelegate> {
  __weak IBOutlet BBView *bubbleView;
}
```

Notice we added the BBDelegate to your ViewController, and make sure you set bubbleView's delegate to self inside ViewDidLoad or wherever you instantiate your BBView.

Now, to fill the BBView with your buttons, first create an NSArray of NSStrings. Ideally, this would tie into data you wish to manipulate - this part is entierly dependent on your project and what you wish to do. BBView also has arguments for the background color, text color and font-size for each button. This is for UI and again, entirely up to you. This is the function you should call inside your ViewController:

```objc
[bubbleView fillBubbleViewWithButtons:NSArray bgColor:UIColor textColor:UIColor fontSize:float];
```

Each UIButton is given a tag based on the index of the array you pass in. Use the <code>-(void)didClickBubbleButton:(UIButton *)bubble;</code> method from the BBDelegate to manipulate your data. Use <code>bubble.tag</code> to do so.

## Contact

If you have any questions comments or suggestions, send me a message. If you find a bug, or want to submit a pull request, let me know.

* klevison@gmail.com
* http://twitter.com/klevison

## Copyright and license

Copyright (c) 2014 Klevison Matias (http://twitter.com/klevison). Code released under [the MIT license](LICENSE).
