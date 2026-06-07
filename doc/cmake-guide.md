# CMake Guide

This guide explains common CMake workflows for GLDiagram.

## Mental Model

CMake work usually has four separate steps:

1. Configure: read `CMakeLists.txt`, choose options, and generate build files.
2. Build: compile sources and link targets using the generated build files.
3. Test: run CTest tests from the configured build tree.
4. Install: copy public artifacts into an install prefix.

Those steps are intentionally separate. If configure fails, the build files are
not reliable. If build fails, tests and install are not meaningful.

## Quick Commands

Use the debug preset for normal development:

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug --output-on-failure
```

On Windows PowerShell, the local wrapper runs the same flow:

```powershell
./scripts/check.ps1
```

On Linux or macOS:

```sh
./scripts/check.sh
```

## Presets

Presets are named build configurations stored in `CMakePresets.json`.

| Preset | Purpose |
| --- | --- |
| `debug` | Fast local development with debug symbols. |
| `release` | Optimized build for release-style validation. |
| `asan` | Debug build with AddressSanitizer and UBSan where supported. |
| `coverage` | Debug build with coverage flags where supported. |

Configure, build, and test presets share the same names:

```sh
cmake --preset release
cmake --build --preset release
ctest --preset release --output-on-failure
```

## Important Options

These options can be passed during configure:

```sh
cmake --preset debug -DGLDIAGRAM_BUILD_APP=OFF
```

| Option | Meaning |
| --- | --- |
| `GLDIAGRAM_BUILD_APP` | Builds the interactive GLDiagram executable. |
| `GLDIAGRAM_BUILD_TESTING` | Builds CTest test targets. |
| `GLDIAGRAM_INSTALL` | Generates install rules for the executable. |
| `GLDIAGRAM_ENABLE_ASAN` | Enables AddressSanitizer where supported. |
| `GLDIAGRAM_ENABLE_UBSAN` | Enables UndefinedBehaviorSanitizer where supported. |
| `GLDIAGRAM_ENABLE_COVERAGE` | Enables coverage flags where supported. |

The app, tests, and install rules default to on for top-level builds. They
default to off when this project is included through `add_subdirectory()`.

## Multi-Config Generators

Visual Studio and Xcode are multi-config generators. They can produce Debug and
Release artifacts from the same build directory, so build and test commands need
an explicit config in some workflows:

```sh
cmake --build build/debug --config Debug
ctest --test-dir build/debug -C Debug --output-on-failure
```

Single-config generators such as Ninja and Make use `CMAKE_BUILD_TYPE` at
configure time instead.

## Add A Source File

Add project-owned implementation files under `src/gldiagram/` and public headers
under `include/gldiagram/`.

1. Create the `.c` file under `src/gldiagram/`.
2. Create or update the matching public header under `include/gldiagram/` when
   the code is public API.
3. Add the new `.c` file to `GLDIAGRAM_APP_SOURCES` or `GLDIAGRAM_VENDOR_SOURCES`
   in `cmake/Sources.cmake`.
4. Add tests under `tests/` where behavior can be automated.
5. Run `./scripts/check.ps1` or `./scripts/check.sh`.

Vendored or generated code should stay isolated so project warnings and static
analysis apply to project-owned code first.

## Add A Test

Use `gldiagram_add_test()` from `cmake/Tests.cmake`:

```cmake
gldiagram_add_test(gldiagram_feature_tests
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_feature.c
)
```

Then run:

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug --output-on-failure
```

Tests should assert public behavior. The interactive OpenGL window is verified
manually, not by automated CI.

## Generated Version Header

The project version is declared once:

```cmake
project(GLDiagram VERSION 1.0.0 LANGUAGES C)
```

CMake generates `gldiagram/version.h` from that value. Source files should use
the generated macros instead of duplicating literal version numbers.

## Troubleshooting

Old CMake cache points at another path:

- Symptom: configure mentions a different source directory.
- Fix: delete the affected build directory, such as `build/release`, and run
  `cmake --preset release` again.

Linux GLFW configure fails with missing X11 headers:

- Symptom: CMake or compilation fails for X11, RandR, Xinerama, Cursor, or Xi.
- Fix: install the Linux packages listed in `doc/build.md`.

`ctest` cannot find a test executable with Visual Studio:

- Symptom: CTest looks in the wrong configuration directory.
- Fix: pass `-C Debug` or `-C Release`, matching the build config.

`clang-format`, `clang-tidy`, or `yamllint` is missing:

- Symptom: local scripts skip a tool or the shell cannot find it.
- Fix: install the tool locally, or rely on CI where the workflow installs the
  required toolchain.
