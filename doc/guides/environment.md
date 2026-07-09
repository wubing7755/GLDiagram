# Environment Setup

This guide walks through installing the tools GLDiagram needs on a new
machine. Follow the section for your platform, then verify everything works.

## Requirements

| Tool | Required | Purpose |
| --- | --- | --- |
| CMake 3.20+ | Yes | Configure and generate build files |
| C11 compiler | Yes | Compile C source (MSVC, GCC, Clang, or AppleClang) |
| OpenGL 3.3 driver | Yes | Run the interactive application |
| clang-format | No | Local formatting checks |
| clang-tidy | No | Optional local static analysis |

The project's check scripts validate these tools. Run them after setup to
confirm your environment is ready.

## Windows

Pick one of the three paths below. Option A (MSVC) is the most tested path in
CI. Option B (MSYS2/UCRT64) provides a Unix-like shell and GCC/Clang. Option C
(WSL) delegates to a Linux distribution.

### Option A: Visual Studio Build Tools (MSVC)

Install **Visual Studio Build Tools 2022** or **Visual Studio 2022** from the
[Visual Studio downloads page](https://visualstudio.microsoft.com/downloads/).
During installation, select the **Desktop development with C++** workload. This
provides the MSVC compiler (`cl.exe`), the Windows SDK, and optional CMake and
Ninja if you enable them in the installer.

If you prefer command-line package management, use winget:

```powershell
winget install Kitware.CMake
winget install Ninja-build.Ninja
winget install LLVM.LLVM
```

The LLVM package includes clang-format and clang-tidy.

**Important:** A normal PowerShell or Command Prompt does not expose `cl.exe`.
Launch **Developer PowerShell for VS 2022** or **Developer Command Prompt for
VS 2022** from the Start Menu before running any build commands. Alternatively,
use a VS Code CMake kit that initializes the MSVC environment.

GLDiagram uses GLFW which requires the **Desktop development with C++** workload
for OpenGL headers.

### Option B: MSYS2 / UCRT64 (GCC or Clang)

Download and install MSYS2 from [msys2.org](https://www.msys2.org/). Accept
the default installation path.

Launch **MSYS2 UCRT64** from the Start Menu. This opens a shell configured for
the Universal C Runtime — the modern Windows C runtime compatible with standard
C11.

Update the package database first:

```sh
pacman -Syu
```

Re-launch the UCRT64 shell if the update requires it, then install the build
tools:

```sh
pacman -S mingw-w64-ucrt-x86_64-cmake
pacman -S mingw-w64-ucrt-x86_64-ninja
pacman -S mingw-w64-ucrt-x86_64-gcc
```

To use Clang instead of GCC:

```sh
pacman -S mingw-w64-ucrt-x86_64-clang
```

Optional tools (clang-format, clang-tidy):

```sh
pacman -S mingw-w64-ucrt-x86_64-clang-tools-extra
```

All tools are available on PATH inside the UCRT64 shell. Git operations work
from this shell as well, since MSYS2 bundles git.

This option produces native Windows binaries through a Unix-like package
manager and shell environment.

### Option C: WSL (Windows Subsystem for Linux)

From an elevated PowerShell or Command Prompt:

```powershell
wsl --install
```

This installs WSL 2 and a default Ubuntu distribution. Reboot if prompted, then
launch the installed Linux distribution from the Start Menu. From this point,
follow the **Linux** section below.

Clone the repository inside the WSL filesystem (`/home/<user>/...`) for the
best build performance. VS Code users should install the **Remote - WSL**
extension to edit files inside WSL from the Windows VS Code UI.

GLFW in WSL requires an X11 server such as VcXsrv or WSLg for window display.

## Linux

Use your distribution's package manager.

### Debian / Ubuntu

```sh
sudo apt update
sudo apt install build-essential cmake ninja-build libgl1-mesa-dev \
  libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
```

To use Clang instead of GCC:

```sh
sudo apt install clang
```

Optional tools:

```sh
sudo apt install clang-format clang-tidy
```

On older Ubuntu releases where CMake 3.20+ is not in the default repositories,
install CMake via pip (`pip install cmake`) or add the
[Kitware APT repository](https://apt.kitware.com/).

### Fedora / RHEL

```sh
sudo dnf install cmake ninja-build gcc mesa-libGL-devel \
  libXrandr-devel libXinerama-devel libXcursor-devel libXi-devel
```

Or with Clang:

```sh
sudo dnf install clang
```

Optional tools:

```sh
sudo dnf install clang-tools-extra
```

### Arch Linux

```sh
sudo pacman -S cmake ninja gcc
```

Or with Clang:

```sh
sudo pacman -S cmake ninja clang
```

Optional tools:

```sh
sudo pacman -S clang
```

The `clang` package on Arch bundles clang-format and clang-tidy.

### Other distributions

Use your package manager to install **cmake**, **ninja**, and **gcc** or
**clang**, plus the OpenGL and X11 development packages. The check script
reports which tools are missing.

## macOS

Install the Xcode Command Line Tools for AppleClang:

```sh
xcode-select --install
```

Install Homebrew from [brew.sh](https://brew.sh/), then:

```sh
brew install cmake ninja
```

Optional tools:

```sh
brew install llvm
```

Homebrew installs LLVM "keg-only" — it is not placed on PATH by default. Add
the path shown in the Homebrew post-install output, typically:

```sh
export PATH="$(brew --prefix llvm)/bin:$PATH"
```

## Verification

From the repository root, run the check script:

**Linux / macOS / MSYS2 UCRT64:**

```sh
./scripts/check.sh
```

**Windows PowerShell (MSVC or winget path):**

```powershell
./scripts/check.ps1
```

The script configures, builds, and runs tests. If something is missing, it
reports a specific error.

## Optional Tools For Editor Integration

- **clang-format**: `./scripts/check.sh` (or `.ps1`) runs `clang-format
  --dry-run` over all C source files. Installing it locally lets you catch
  formatting issues before pushing.

- **clang-tidy**: run with `./scripts/check.sh debug tidy` (or `.ps1
  -EnableTidy`). It uses the project `.clang-tidy` configuration. CI also runs
  clang-tidy, so local installation is optional.

## Next Steps

- **Build and test**: see [cmake-guide.md](../cmake-guide.md) for configure,
  build, test, presets, and troubleshooting.
- **Testing**: see [testing.md](../testing.md) for test expectations and static
  analysis.
- **Contributing**: see [../../CONTRIBUTING.md](../../CONTRIBUTING.md) for
  branch, commit, and PR workflow.
- **Project standard**: see [../../C_PROJECT_STANDARD.md](../../C_PROJECT_STANDARD.md)
  for the full engineering standard.
