# fn2zig
FastNoise2 binding/wrapper for Zig.

Made in a day or two, super incomplete, but slightly ziggified.

To include in your project, run zig fetch like normal, then add this to your build.zig:
```zig
    const fn2zig = b.dependency("fn2zig", .{});
    module.addImport("fn2zig", fn2zig.module("fn2zig"));
```

Example use:
```zig
    //Import, obviously
    const fn2zig = @import("fn2zig");

    // Create a node from encoded tree
    const node = fn2zig.fromEncodedTree("DQAFAAAAAAAAQAgAAAAAAD8AAAAAAA==");

    // genUniform, genPositionArray, and genSingle are available in 2d, 3d, and 4d.
    node.genSingle2D(x, y, seed);
```


## Notes

This isn't a proper full wrapper, we don't have all the FastNoise2 functions and types ziggified yet. If you wanna use the C API directly, `fn2zig.FastNoiseC` has all the functions exposed. You can just pass in the value of the `ptr` field from a SmartNode and it should work.

This library also uses Zig's build system to compile FastNoise2, rather than using prebuilt binaries or requiring the user to install CMake. The early stages of this project mean that none of the options you can find for FastNoise2's CMake project exist yet, and I doubt ARM will compile correctly. I wanna make sure that stuff works later, though.

This library is purely for the FastNoise2 library itself, it doesn't compile or touch NoiseTool in any way.