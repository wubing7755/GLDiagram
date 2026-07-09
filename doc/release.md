# Release

This project does not prescribe a release tool. A typical release should:

1. Confirm `project(... VERSION ...)` in `CMakeLists.txt`.
2. Update README, docs, and dependency notes if behavior changed.
3. Run debug, release, and sanitizer checks where supported.
4. Run a manual GUI smoke check on at least one platform with a graphics session.
5. Tag from a clean main branch after CI passes.

Do not publish releases from AI-assisted changes without maintainer approval.

## Suggested Verification

For detailed command explanations, see `cmake-guide.md`. A release-oriented
local check usually includes:

**Linux/macOS**

```sh
./scripts/check.sh
cmake --preset release
cmake --build --preset release
ctest --preset release --output-on-failure
cmake --preset asan
cmake --build --preset asan
ctest --preset asan --output-on-failure
```

**Windows PowerShell**

```powershell
./scripts/check.ps1
cmake --preset release
cmake --build --preset release
ctest --preset release --output-on-failure
cmake --preset asan
cmake --build --preset asan
ctest --preset asan --output-on-failure
```

## Install Smoke

```sh
cmake --install build/release --config Release --prefix install
```

## Manual GUI Smoke

```sh
./build/release/bin/GLDiagram
```

On Windows:

```powershell
.\build\release\bin\GLDiagram.exe
```
