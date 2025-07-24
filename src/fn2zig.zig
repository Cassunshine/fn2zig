const std = @import("std");
const testing = std.testing;

pub const FastNoiseC = @cImport({
    @cInclude("stdbool.h");
    @cInclude("FastNoise/FastNoise_C.h");
});

pub fn fromEncodedTree(encoded: []const u8) !SmartNode {
    const ptr = FastNoiseC.fnNewFromEncodedNodeTree(encoded, 0);

    if (ptr == null) {
        return error.InvalidNodeTree;
    }

    return SmartNode{ .ptr = ptr };
}

pub const SmartNode = struct {
    ptr: *anyopaque,

    pub fn genUniformGrid2D(self: *SmartNode, target: []f32, xStart: i32, yStart: i32, xSize: u32, ySize: u32, frequency: f32, seed: u32) void {
        FastNoiseC.fnGenUniformGrid2D(self.ptr, target.ptr, xStart, yStart, xSize, ySize, frequency, seed, &.{ 0, 0 });
    }

    pub fn genUniformGrid3D(self: *SmartNode, target: []f32, xStart: i32, yStart: i32, zStart: i32, xSize: u32, ySize: u32, zSize: u32, frequency: f32, seed: u32) void {
        FastNoiseC.fnGenUniformGrid3D(self.ptr, target.ptr, xStart, yStart, zStart, xSize, ySize, zSize, frequency, seed, &.{ 0, 0 });
    }

    pub fn genUniformGrid4D(self: *SmartNode, target: []f32, xStart: i32, yStart: i32, zStart: i32, wStart: i32, xSize: u32, ySize: u32, zSize: u32, wSize: u32, frequency: f32, seed: u32) void {
        FastNoiseC.fnGenUniformGrid4D(self.ptr, target.ptr, xStart, yStart, zStart, wStart, xSize, ySize, zSize, wSize, frequency, seed, &.{ 0, 0 });
    }

    pub fn genUniformGrid2DOuputMinMax(self: *SmartNode, target: []f32, xStart: i32, yStart: i32, xSize: u32, ySize: u32, frequency: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenUniformGrid2D(self.ptr, target.ptr, xStart, yStart, xSize, ySize, frequency, seed, outputMinMax);
    }

    pub fn genUniformGrid3DOuputMinMax(self: *SmartNode, target: []f32, xStart: i32, yStart: i32, zStart: i32, xSize: u32, ySize: u32, zSize: u32, frequency: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenUniformGrid3D(self.ptr, target.ptr, xStart, yStart, zStart, xSize, ySize, zSize, frequency, seed, outputMinMax);
    }

    pub fn genUniformGrid4DOuputMinMax(self: *SmartNode, target: []f32, xStart: i32, yStart: i32, zStart: i32, wStart: i32, xSize: u32, ySize: u32, zSize: u32, wSize: u32, frequency: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenUniformGrid4D(self.ptr, target.ptr, xStart, yStart, zStart, wStart, xSize, ySize, zSize, wSize, frequency, seed, outputMinMax);
    }

    pub fn genPositionArray2D(self: *SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, xOffset: f32, yOffset: f32, seed: u32) void {
        FastNoiseC.fnGenPositionArray2D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, xOffset, yOffset, seed, &.{ 0, 0 });
    }

    pub fn genPositionArray3D(self: *SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, zPositions: []f32, xOffset: f32, yOffset: f32, zOffset: f32, seed: u32) void {
        FastNoiseC.fnGenPositionArray3D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, zPositions.ptr, xOffset, yOffset, zOffset, seed, &.{ 0, 0 });
    }

    pub fn genPositionArray4D(self: *SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, zPositions: []f32, wPositions: []f32, xOffset: f32, yOffset: f32, zOffset: f32, wOffset: f32, seed: u32) void {
        FastNoiseC.fnGenPositionArray4D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, zPositions.ptr, wPositions.ptr, xOffset, yOffset, zOffset, wOffset, seed, &.{ 0, 0 });
    }

    pub fn genPositionArray2DOuputMinMax(self: *SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, xOffset: f32, yOffset: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenPositionArray2D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, xOffset, yOffset, seed, outputMinMax);
    }

    pub fn genPositionArray3DOuputMinMax(self: *SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, zPositions: []f32, xOffset: f32, yOffset: f32, zOffset: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenPositionArray3D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, zPositions.ptr, xOffset, yOffset, zOffset, seed, outputMinMax);
    }

    pub fn genPositionArray4DOuputMinMax(self: *SmartNode, target: []f32, xPositions: []f32, yPositions: []f32, zPositions: []f32, wPositions: []f32, xOffset: f32, yOffset: f32, zOffset: f32, wOffset: f32, seed: u32, outputMinMax: [2]f32) void {
        FastNoiseC.fnGenPositionArray4D(self.ptr, target.ptr, xPositions.len, xPositions.ptr, yPositions.ptr, zPositions.ptr, wPositions.ptr, xOffset, yOffset, zOffset, wOffset, seed, outputMinMax);
    }

    pub fn genSingle2D(self: *SmartNode, x: f32, y: f32, seed: u32) f32 {
        return FastNoiseC.fnGenSingle2D(self.ptr, x, y, seed);
    }

    pub fn genSingle3D(self: *SmartNode, x: f32, y: f32, z: f32, seed: u32) f32 {
        return FastNoiseC.fnGenSingle3D(self.ptr, x, y, z, seed);
    }

    pub fn genSingle4D(self: *SmartNode, x: f32, y: f32, z: f32, w: f32, seed: u32) f32 {
        return FastNoiseC.fnGenSingle4D(self.ptr, x, y, z, w, seed);
    }
};
