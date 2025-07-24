const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    //const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.addModule(
        "fn2zig",
        .{
            .root_source_file = b.path("src/fn2zig.zig"),
            .target = target,
            .optimize = .ReleaseFast,
        },
    );

    lib_mod.link_libc = true;
    lib_mod.link_libcpp = true;
    lib_mod.addIncludePath(b.path("libs/FastNoise2/include"));

    lib_mod.addCSourceFiles(.{
        .root = b.path("libs/FastNoise2/src"),
        .files = &.{
            "FastNoise/FastNoise_C.cpp",
            "FastNoise/Metadata.cpp",
            "FastNoise/SmartNode.cpp",
            "FastNoise/Base64.h",
            "FastSIMD/FastSIMD.cpp",
        },
        .flags = &.{
            "-DFASTNOISE_C_IMPLEMENTATION",
            "-DFASTNOISE_C_EXPORTS",
            "-ffast-math",
            "-fno-stack-protector",
        },
        .language = .cpp,
    });

    // Add SIMD files

    lib_mod.addCSourceFile(.{ .file = b.path("libs/FastNoise2/src/FastSIMD/FastSIMD_Level_Scalar.cpp"), .flags = &.{"-msse"}, .language = .cpp });
    lib_mod.addCSourceFile(.{ .file = b.path("libs/FastNoise2/src/FastSIMD/FastSIMD_Level_SSE2.cpp"), .flags = &.{"-msse2"}, .language = .cpp });
    lib_mod.addCSourceFile(.{ .file = b.path("libs/FastNoise2/src/FastSIMD/FastSIMD_Level_SSE3.cpp"), .flags = &.{"-msse3"}, .language = .cpp });
    lib_mod.addCSourceFile(.{ .file = b.path("libs/FastNoise2/src/FastSIMD/FastSIMD_Level_SSSE3.cpp"), .flags = &.{"-mssse3"}, .language = .cpp });
    lib_mod.addCSourceFile(.{ .file = b.path("libs/FastNoise2/src/FastSIMD/FastSIMD_Level_SSE41.cpp"), .flags = &.{"-msse4.1"}, .language = .cpp });
    lib_mod.addCSourceFile(.{ .file = b.path("libs/FastNoise2/src/FastSIMD/FastSIMD_Level_SSE42.cpp"), .flags = &.{"-msse4.2"}, .language = .cpp });
    lib_mod.addCSourceFile(.{ .file = b.path("libs/FastNoise2/src/FastSIMD/FastSIMD_Level_AVX2.cpp"), .flags = &.{ "-mavx2", "-mfma" }, .language = .cpp });
    lib_mod.addCSourceFile(.{ .file = b.path("libs/FastNoise2/src/FastSIMD/FastSIMD_Level_AVX512.cpp"), .flags = &.{ "-mavx512f", "-mavx512dq", "-mfma" }, .language = .cpp });

    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "fn2zig",
        .root_module = lib_mod,
    });
    b.installArtifact(lib);
    lib.linkLibC();
    lib.linkLibCpp();

    const lib_unit_tests = b.addTest(.{
        .root_module = lib_mod,
    });

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}
