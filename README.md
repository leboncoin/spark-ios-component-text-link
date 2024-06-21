# Textlink
A textlink is a reference to a resource.

It can be external (e.g. a different web page) or internal (e.g. a specific element in the current page).

## Specifications
The textlink specifications on Zeroheight is [here](https://spark.adevinta.com/1186e1705/p/75ed11-textlink).

![Figma anatomy](https://github.com/adevinta/spark-ios-component-text-link/blob/main/.github/assets/anatomy.png)

## Usage
Textlink is available both in UIKit and SwiftUI.

### UIKIt

#### Properties
* `theme`: The current Spark-Theme. [You can always define your own theme.](https://github.com/adevinta/spark-ios/wiki/Theming#your-own-theming)
* `text`: The text of the text link.
* `intent`: The intent of the text link.
* `textHighlightRange`: The optional range to specify the highlighted part of the text link.
* `typography`: The typography of the text link.
* `variant`: The variant of the text link.
* `image`: The optional image of the text link.
* `alignment`: The alignment of the text link.
* `textAlignment`: The text  alignment  of the textlink. Default is **.natural**.
* `lineBreakMode`: The line break mode of the textlink. Default is **.byTruncatingTail**.
* `numberOfLines`: The number of lines of the textlink. Default is **1**.
* `isHighlighted`: A Boolean value indicating whether the text link draws a highlight.

#### Published Properties:
* `tapPublisher`: The publisher used to notify when the user tap on the textlink.

#### Initialization

There is only one possibility to initialize the textlink.

```swift
let textLink = TextLinkUIView(
    theme: theme,
    text: "My textLink",
    textHighlightRange: NSRange(location: 3, length: 8), // Optional. Default is nil.
    intent: .main,
    typography: .body1,
    variant: .underline,
    image: UIImage(named: "textlink_image"), // Optional.
    alignment: .trailingImage // Default is .leadingImage.
)
```

#### Constraints

You can change the **label compression resistance priority** and the **label hugging priority** with this two methods:

```swift
myTextLink.setLabelContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
myTextLink.setLabelContentHuggingPriority(.defaultHigh, for: .horizontal)
```
### SwiftUI

#### Initialization

There is only one possibility to initialize the textlink.

```swift
let textLink = TextLinkView(
    theme: theme,
    text: "My textLink",
    textHighlightRange: NSRange(location: 3, length: 8), // Optional. Default is nil.
    intent: .main,
    typography: .body1,
    variant: .underline,
    image: Image(named: "textlink_image"), // Optional.
    alignment: .trailingImage, // Default is .leadingImage.
    action: {
        print("My textLink is tapped !")
    }
)
```

## License

```
MIT License

Copyright (c) 2024 Adevinta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```