# Build

For detailed CMake workflow explanations, see `cmake-guide.md`. This page is a
quick reference for supported commands and options.

## Requirements

- CMake 3.20 or newer
- Ninja, Make, Visual Studio, Xcode, or another CMake generator
- A C11 compiler
- OpenGL 3.3 capable graphics driver

Linux builds need OpenGL and X11 development packages. See
[guides/environment.md](guides/environment.md) for platform-specific setup
instructions.

## Presets

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug --output-on-failure
```

Available presets:

- `debug`
- `release`
- `asan`
- `coverage`

Common options:

- `GLDIAGRAM_BUILD_APP` builds the interactive application.
- `GLDIAGRAM_BUILD_TESTING` builds CTest test targets.
- `GLDIAGRAM_INSTALL` generates install rules for the application.
- `GLDIAGRAM_ENABLE_ASAN` enables AddressSanitizer where supported.
- `GLDIAGRAM_ENABLE_UBSAN` enables UndefinedBehaviorSanitizer where supported.
- `GLDIAGRAM_ENABLE_COVERAGE` enables coverage flags where supported.

The app, tests, and install rules default to on for top-level builds and off
when this project is included as a subproject.

Use `cmake -LAH -S . -B build/debug` after configuring if you need to inspect
available cache options.

## Local Check Scripts

```sh
./scripts/check.sh
```

```powershell
./scripts/check.ps1
```

Optional clang-tidy checks require `clang-tidy`:

```sh
./scripts/check.sh debug tidy
```

```powershell
./scripts/check.ps1 -EnableTidy
```

## Install

Install a configured release build with CMake:

```sh
cmake --preset release
cmake --build --preset release
cmake --install build/release --config Release --prefix install
```

The current install rule installs the GLDiagram executable. It does not publish
a CMake package config because GLDiagram is currently an application, not a
library API package.

## Dependency Notes

GLFW is fetched by CMake. GLAD and Nuklear are vendored so the OpenGL loader and
GUI backend remain deterministic. Keep dependency changes intentional and note
upstream versions or generation commands in PRs.
