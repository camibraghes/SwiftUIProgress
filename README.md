# SwiftUI Thinking

This project was designed to help SwiftUI developers improve their skills with more advanced components and techniques. It is a collection of individual projects and not a single, bound application.
The source for these tutorials is [here](https://www.youtube.com/watch?v=S5e1eXL8Vpk&list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar).

I followed the lessons and implemented the examples, one by one while exploring the possibilities and limitations of Swift and SwiftUI.

There is a great number of topics covered such as:

- custom gestures
- `Codable`& `Decodable`
- REST API implementation using `Combine`
- `Publisher`s and Subscribers in `Combine`
- Data persistence using `CoreData`
- Downloading and storing images with `FileManager` and `NSCache`

### Project components and features breakdown

The following files contain the implementation of user gestures: `LongPressGesture`,  `MagnificationGesture`,  `RotationGesture`, and `DragGesture`.

The following files contain design implementation for dynamic UI components: 

`ScrollViewReader` - A view that provides programmatic scrolling, by working with a proxy to scroll through child views.

`GeometryReader` - A container view that defines its content as a function of its own size and coordinate space.

`MultipleSheets` - An array of the sheets currently attached to the window that can be accessed one by one.

`Mask` - A quick little rating component where you can rate something from 1 to 5 stars.

The following two files contain the implementation of features using the hardware of the device:

`SoundsView` - Adding a sound effect and vibration when tapping a button

`Haptics` -  Settings different default vibrations for the application.

`LocalNotification` - Important to understand the difference between a real push notification and a local notification. The main difference here is that local notifications can be set up within the application programmatically, while the real push notifications come from a server.

`HashableView` - The `Hashable` protocol is a type that can be hashed into a hasher to produce an integer hash value.

Work around `CoreData` (a powerful mobile database allowing developers to create high-performance, data-driven iOS, and macOS applications) is contained in the `CoreDataRelation` and `CoreDataContainer`. Here I’ve worked with:

- `@FetchRequest` - Fetch requests allow us to load `CoreData` results that match specific criteria we specify, and SwiftUI can bind those results directly to user interface elements.
- `CoreData` with `MVVM` (Model-View-ViewModel is a software architectural pattern that facilitates the separation of the development of the graphical user interface from the development of the business logic or back-end logic so that the view is not dependent on any specific model platform).
- `CoreData` relationships, predicate, and delete rules. I have created three entities: businesses, departments, and employees where all three are going to be related. A business will have many different departments and many different employees. An employee will be part of a business and a department.

`BackgroundThread` and `WeakSelf` files contain examples of using background queues or threads (in Swift, `weak self` creates a weak reference to self in a closure which prevents memory leaks due to strong reference cycles).

`Typealias` is used to provide a new name for an existing data type in the program. Once you create a typealias, you can use the aliased name instead of the existing name throughout the program. Typealias doesn't create a new data type, it simply provides a new name to the existing data type.

An `Escaping` closure is a closure that's called after the function it was passed to returns. In other words, it outlives the function it was passed to.

The `CodableProtocol` file contains examples for `Codable`, `Decodable`, and `Encodable` (which is a union of the previous 2 protocols). These protocols are used to indicate whether a certain `struct`, `enum`, or `class`, can be encoded into `JSON` `Data`, or materialized from `JSON` `Data`. 

`DownloadWithEscaping` contains examples of working with background threads, escaping closures, and conversions from web data into data that we can use in our app. I’m using a free public API to download some test data. `DownloadWithCombine` does the same thing but using `Combine` (a new framework from Apple that takes advantage of using publishers and subscribers).

`Timer` is a simple file, where I’ve implemented a timer that fires after a certain time interval has elapsed, sending a specified message to a target object.

`SubscriberView` is about a publisher-subscriber relationship in Combine. A publisher-subscriber relationship is solidified in a third object, the subscription. When a subscriber is created and subscribes to a publisher, the publisher will create a subscription object and it passes a reference to the subscription to the subscriber.

`FileManagerData` and `CacheImage` files deal with downloading and caching an image.

`FileManager` allows you to save images, audio, and video files to your device. A convenient interface to the contents of the file system, and the primary means of interacting with it. We should use this sparingly because this is saving data to the user’s device. `FileManager` is for more permanent objects that will save to the device forever

Caching is a supplementary memory system that temporarily stores frequently used instructions and data for quicker processing by the central processing unit (CPU) of a computer. In this file, we will implement a simple `NSCache` to temporarily save an image. Caching is a very common technique used in all software development where we can take objects that we've downloaded from the internet and temporarily store them somewhere for reuse. This helps us avoid having to re-download the objects if they appear on the screen a second time.

The `DownloadingImages` folder contains a small example of the capabilities explored above structured together in an MVVM architecture.
