# LDtkLoader_ZigBuild
This is [LDtkLoader](https://github.com/Madour/LDtkLoader), packaged for [Zig](https://ziglang.org/). (Intended for C++ projects using Zig as a build tool.)

## Usage
First, update your `build.zig.zon`:
```sh
zig fetch --save git+https://github.com/jessechounard/LDtkLoader_ZigBuild
```

Next, in your `build.zig`, you can access the library as a dependency:
```zig
const ldtk_dep = b.dependency("LDtkLoader", .{
    .target = target,
    .optimize = optimize,
});
const ldtk_lib = ldtk_dep.artifact("LDtkLoader");

exe.root_module.linkLibrary(ldtk_lib);
```

Finally, in your C++ file, you can use the library:
```cpp
#include <LDtkLoader/Project.hpp>

int main() {
    ldtk::Project ldtkProject;
    ldtkProject.loadFromFile("test.ldtk");
    const auto &world = ldtkProject.getWorld();
  
    // use world here

    return 0;
}
```

## Notes
### Target git repo
Currently the original LDtkLoader repo won't build for me in Clang, so instead of pointing at that, I've created a fork where I've commented out a few lines and we're pointing at the fork instead. I've created an issue there. If this is resolved, I'll get rid of my fork and point to the original.

### Version number
I normally try to match the release version of the library I'm bundling with zig, since I'm not adding anything to it. Unfortunately, LDtkLoader uses a four number versioning system (major.minor.patch.tweak) while zig build versions only seem to support three number semantic versioning. So I've dropped the tweak version.

### Version header
LDtkLoader includes an header file (`Version.hpp`) that is generated as part of its CMake build. Rather than try to mimic that somehow, I've just created a copy and included it as part of the build. This will have to be updated for new versions, but it's pretty trivial. If anyone has a better suggestion, please let me know.

### Build option
LDtkLoader includes a few CMake configuration options. I haven't added support for them here, but it shouldn't be too much trouble to add them if anyone needs them.
