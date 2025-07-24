const std = @import("std");
const testing = std.testing;

pub const FastNoiseC = @cImport({
    @cInclude("stdbool.h");
    @cInclude("FastNoise/FastNoise_C.h");
});

test "Test from encoded tree" {
    const node = try fromEncodedTree("DQAFAAAAAAAAQAgAAAAAAD8AAAAAAA==");

    std.debug.print("Noise value : {}\n", .{node.genSingle2D(1.0, 0.0, 0)});
}

pub fn fromEncodedTree(encoded: [:0]const u8) !SmartNode {
    const ptr = FastNoiseC.fnNewFromEncodedNodeTree(@ptrCast(encoded.ptr), 0);

    if (ptr) |valid| {
        return SmartNode{ .ptr = valid };
    } else {
        return error.InvalidNodeTree;
    }
}

pub const SmartNode = struct {
    ptr: *anyopaque,

    pub fn destroy(self: *const SmartNode) void {
        FastNoiseC.fnDeleteNodeRef(self.ptr);
    }

    pub fn genUniformGrid2D(self: *const SmartNode, target: []f32, xStart: i32, yStart: i32, xSize: u32, ySize: u32, frequency: f32, seed: u32) void {
        const minMax = [2]f32{ 0, 0 };
        self.genUniformGrid2DOuputMinMax(target, xStart, yStart, xSize, ySize, frequency, seed, minMax);
    }

    pub fn genUniformGrid3D(self: *const SmartNode, target: []f32, xStart: i32, yStart: i32, zStart: i32, xSize: u32, ySize: u32, zSize: u32, frequency: f32, seed: u32) void {
        const minMax = [2]f32{ 0, 0 };
        self.genUniformGrid3DOuputMinMax(target, xStart, yStart, zStart, xSize, ySize, zSize, frequency, seed, minMax);
    }

    pub fn genUniformGrid4D(self: *const SmartNode, target: []f32, xStart: i32, yStart: i32, zStart: i32, wStart: i32, xSize: u32, ySize: u32, zSize: u32, wSize: u32, frequency: f32, seed: u32) void {
        const minMax = [2]f32{ 0, 0 };
        self.genUniformGrid4DOuputMinMax(target, xStart, yStart, zStart, wStart, xSize, ySize, zSize, wSize, frequency, seed, minMax);
    }

    pub fn genUniformGrid2DOuputMinMax(self: *const SmartNode, target: []f32, xStart: i32, yStart: i32, xSize: u32, ySize: u32, frequency: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenUniformGrid2D(self.ptr, target.ptr, @bitCast(xStart), @bitCast(yStart), @bitCast(xSize), @bitCast(ySize), frequency, @bitCast(seed), @ptrCast(@constCast(&outputMinMax)));
    }

    pub fn genUniformGrid3DOuputMinMax(self: *const SmartNode, target: []f32, xStart: i32, yStart: i32, zStart: i32, xSize: u32, ySize: u32, zSize: u32, frequency: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenUniformGrid3D(self.ptr, target.ptr, @bitCast(xStart), @bitCast(yStart), @bitCast(zStart), @bitCast(xSize), @bitCast(ySize), @bitCast(zSize), frequency, @bitCast(seed), @ptrCast(@constCast(&outputMinMax)));
    }

    pub fn genUniformGrid4DOuputMinMax(self: *const SmartNode, target: []f32, xStart: i32, yStart: i32, zStart: i32, wStart: i32, xSize: u32, ySize: u32, zSize: u32, wSize: u32, frequency: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenUniformGrid4D(self.ptr, target.ptr, @bitCast(xStart), @bitCast(yStart), @bitCast(zStart), @bitCast(wStart), @bitCast(xSize), @bitCast(ySize), @bitCast(zSize), @bitCast(wSize), frequency, @bitCast(seed), @ptrCast(@constCast(&outputMinMax)));
    }

    pub fn genPositionArray2D(self: *const SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, xOffset: f32, yOffset: f32, seed: u32) void {
        const minMax = [2]f32{ 0, 0 };
        self.genPositionArray2DOuputMinMax(target, xPositions, yPositions, xOffset, yOffset, seed, minMax);
    }

    pub fn genPositionArray3D(self: *const SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, zPositions: []f32, xOffset: f32, yOffset: f32, zOffset: f32, seed: u32) void {
        const minMax = [2]f32{ 0, 0 };
        self.genPositionArray3DOuputMinMax(target, xPositions, yPositions, zPositions, xOffset, yOffset, zOffset, seed, minMax);
    }

    pub fn genPositionArray4D(self: *const SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, zPositions: []f32, wPositions: []f32, xOffset: f32, yOffset: f32, zOffset: f32, wOffset: f32, seed: u32) void {
        const minMax = [2]f32{ 0, 0 };
        self.genPositionArray4DOuputMinMax(target, xPositions, yPositions, zPositions, wPositions, xOffset, yOffset, zOffset, wOffset, seed, minMax);
    }

    pub fn genPositionArray2DOuputMinMax(self: *const SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, xOffset: f32, yOffset: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenPositionArray2D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, xOffset, yOffset, @bitCast(seed), @ptrCast(@constCast(&outputMinMax)));
    }

    pub fn genPositionArray3DOuputMinMax(self: *const SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, zPositions: []f32, xOffset: f32, yOffset: f32, zOffset: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenPositionArray3D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, zPositions.ptr, xOffset, yOffset, zOffset, @bitCast(seed), @ptrCast(@constCast(&outputMinMax)));
    }

    pub fn genPositionArray4DOuputMinMax(self: *const SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, zPositions: []f32, wPositions: []f32, xOffset: f32, yOffset: f32, zOffset: f32, wOffset: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenPositionArray4D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, zPositions.ptr, wPositions.ptr, xOffset, yOffset, zOffset, wOffset, @bitCast(seed), @ptrCast(@constCast(&outputMinMax)));
    }

    pub fn genSingle2D(self: *const SmartNode, x: f32, y: f32, seed: u32) f32 {
        return FastNoiseC.fnGenSingle2D(self.ptr, x, y, @bitCast(seed));
    }

    pub fn genSingle3D(self: *const SmartNode, x: f32, y: f32, z: f32, seed: u32) f32 {
        return FastNoiseC.fnGenSingle3D(self.ptr, x, y, z, @bitCast(seed));
    }

    pub fn genSingle4D(self: *const SmartNode, x: f32, y: f32, z: f32, w: f32, seed: u32) f32 {
        return FastNoiseC.fnGenSingle4D(self.ptr, x, y, z, w, @bitCast(seed));
    }
};
