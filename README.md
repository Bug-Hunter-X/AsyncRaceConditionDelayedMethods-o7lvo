# Objective-C ARC Race Condition

This repository demonstrates a common race condition in Objective-C related to Automatic Reference Counting (ARC) and delayed method execution.  The issue occurs when an object is created and a method referencing that object is scheduled for execution using `performSelector:withObject:afterDelay:`. If the object's lifecycle ends before the delayed method is invoked, a crash or unpredictable behavior may result.

The `bug.m` file shows the erroneous code. The solution is provided in `bugSolution.m`.