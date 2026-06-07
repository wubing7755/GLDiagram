# GLDiagram

GLDiagram is a C11 OpenGL 3.3 drawing canvas with a Nuklear immediate-mode GUI.
The repository has been shaped to follow the local `c-project-standard`
template: modular CMake, presets, CTest, local check scripts, CI, and short
maintenance documentation.

## Quick Start

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug --output-on-failure
```

Run the application after building:

```sh
./build/debug/bin/GLDiagram
```

On Windows PowerShell:

```powershell
./scripts/check.ps1
.\build\debug\bin\GLDiagram.exe
```

On Linux/macOS:

```sh
./scripts/check.sh
./build/debug/bin/GLDiagram
```

## Requirements

- CMake 3.20 or newer
- A C11-compatible compiler
- OpenGL 3.3 capable graphics driver

Linux builds need OpenGL and X11 development packages. On Debian or Ubuntu:

```sh
sudo apt-get install build-essential cmake libgl1-mesa-dev \
  libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
```

## Presets

Available CMake presets:

- `debug`
- `release`
- `asan`
- `coverage`

Common commands:

```sh
cmake --preset release
cmake --build --preset release
ctest --preset release --output-on-failure
```

## Layout

```text
include/        Public and vendored headers
src/            Application source and isolated vendor implementation
tests/          CTest test programs
cmake/          CMake modules
scripts/        Local check entry points
doc/            Contributor documentation
.github/        CI, issue, and PR templates
```

Project-owned public headers belong under `include/gldiagram/`. GLAD, KHR, and
Nuklear headers keep their upstream include namespaces.

## Dependencies

- GLFW 3.3.9 is fetched by CMake with `FetchContent`.
- OpenGL is discovered with `find_package(OpenGL REQUIRED)`.
- GLAD is vendored as generated source/header files.
- Nuklear is vendored as single-header source and GLFW backend header.

GLAD can be regenerated with:

```sh
glad --generator=c --profile=compatibility --api=gl:3.3 --out-path=include/glad/
```

## Documentation Map

- [doc/cmake-guide.md](doc/cmake-guide.md) explains day-to-day CMake usage.
- [doc/build.md](doc/build.md) lists supported presets, options, and commands.
- [doc/testing.md](doc/testing.md) describes automated and manual checks.
- [doc/template.md](doc/template.md) records how the C template was applied.
- [CONTRIBUTING.md](CONTRIBUTING.md) describes contribution workflow.
- [SECURITY.md](SECURITY.md) describes vulnerability and dependency handling.
- [C_PROJECT_STANDARD.md](C_PROJECT_STANDARD.md) defines the local project
  standard.

## License

MIT License. See [LICENSE.txt](LICENSE.txt).
