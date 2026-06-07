# Release

This project does not prescribe a release tool. A typical release should:

1. Confirm `project(... VERSION ...)` in `CMakeLists.txt`.
2. Update README, docs, and dependency notes if behavior changed.
3. Run debug, release, and sanitizer checks where supported.
4. Run a manual GUI smoke check on at least one platform with a graphics session.
5. Tag from a clean main branch after CI passes.

Suggested commands:

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug --output-on-failure

cmake --preset release
cmake --build --preset release
ctest --preset release --output-on-failure

cmake --preset asan
cmake --build --preset asan
ctest --preset asan --output-on-failure
```

Install smoke:

```sh
cmake --install build/release --config Release --prefix install
```

Manual GUI smoke:

```sh
./build/release/bin/GLDiagram
```

On Windows:

```powershell
.\build\release\bin\GLDiagram.exe
```
