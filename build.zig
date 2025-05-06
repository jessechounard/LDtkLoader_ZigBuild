const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("LDtkLoader", .{});
    const lib = b.addStaticLibrary(.{
        .name = "LDtkLoader",
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
    lib.linkLibCpp();
    lib.addIncludePath(upstream.path("include"));
    lib.addIncludePath(b.path("include"));
    lib.addCSourceFiles(.{
        .root = upstream.path("src"),
        .files = &.{
            "DataTypes.cpp",
            "Entity.cpp",
            "EntityDef.cpp",
            "Enum.cpp",
            "FieldsContainer.cpp",
            "Layer.cpp",
            "LayerDef.cpp",
            "Level.cpp",
            "Project.cpp",
            "TagsContainer.cpp",
            "Tile.cpp",
            "Tileset.cpp",
            "Utils.cpp",
            "World.cpp",
        },
    });
    lib.installHeadersDirectory(upstream.path("include/LDtkLoader"), "LDtkLoader", .{ .include_extensions = &.{
        "hpp",
    } });
    lib.installHeader(b.path("include/LDtkLoader/Version.hpp"), "LDtkLoader/Version.hpp");

    b.installArtifact(lib);
}
