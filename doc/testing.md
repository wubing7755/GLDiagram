# Testing

Use CTest for automated tests.

```sh
ctest --preset debug --output-on-failure
```

For command details and generator-specific flags, see `cmake-guide.md`.

## Expectations

- Bug fixes should include regression tests where practical.
- New public APIs should include success and failure cases.
- Tests should assert behavior, not line coverage.
- Prefer focused test programs over broad integration tests for small modules.
- Do not launch the interactive OpenGL window in automated CI tests.

## Static Analysis

CI runs clang-format, clang-tidy, cppcheck, and YAML linting. Local clang-tidy
checks are optional because tool availability varies by platform:

```sh
./scripts/check.sh debug tidy
```

```powershell
./scripts/check.ps1 -EnableTidy
```

Vendored GLAD, KHR, and Nuklear files are excluded from project formatting and
static analysis. Update them intentionally as dependency artifacts.

## What To Run

| Change type | Minimum useful checks |
| --- | --- |
| C source or project header | `./scripts/check.ps1` or `./scripts/check.sh` |
| CMake or dependency change | `debug`, `release`, and relevant sanitizer preset |
| CI or YAML change | `git diff --check` and CI static analysis |
| GUI behavior change | Automated checks plus a documented manual app run |
| Release-sensitive change | `release`, `asan`, and install smoke command |

## Manual Checks

Document manual checks in PRs when behavior cannot be exercised by CTest.
Manual checks should include the command, platform, and observed result.
