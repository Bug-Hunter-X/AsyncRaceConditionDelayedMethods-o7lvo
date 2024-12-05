The solution is to ensure the object's lifetime is extended to cover the execution of the delayed method. One approach is to use a strong reference within a property that is retained beyond the duration of `someMethod`. Another approach is to use blocks or GCD to manage object lifetime more precisely:

```objectivec
@property (strong, nonatomic) MyObject *myObject;

- (void)someMethod {
    __weak typeof(self) weakSelf = self; // Prevent strong cycle
    self.myObject = [[MyObject alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ 
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (strongSelf.myObject) {
                [strongSelf anotherMethod];
            } else {
                NSLog("myObject is nil."); // Handle nil gracefully
            }
        }
    });
}

- (void)anotherMethod {
    // ... use self.myObject safely ...
}
```

This version uses `dispatch_after` to execute `anotherMethod` on the main queue after a 1 second delay. The weak `weakSelf` prevents strong reference cycles, and the strong `strongSelf` ensures the object exists if the block is executed.  Always check for `nil` before accessing the object.