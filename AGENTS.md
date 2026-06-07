# AGENTS.md

Repository-specific instructions for AI agents.

## Required Reading

Before changing files, read:

- `CONTRIBUTING.md`
- `doc/testing.md`
- `doc/ai-agents.md`
- `doc/agent-playbooks.md`

For architecture-sensitive changes, also read:

- `doc/adr/README.md`
- Relevant ADR files under `doc/adr/`

For build, CI, dependency, release, or security work, also read:

- `doc/build.md`
- `doc/cmake-guide.md`
- `doc/release.md`
- `SECURITY.md`

## Project Shape

This is a C11 OpenGL application using CMake and CTest.

```text
include/        Public and vendored headers
src/            Application and isolated vendor implementation files
tests/          CTest tests
cmake/          Build modules
scripts/        Local check wrappers
doc/            Contributor documentation
```

## Build And Verification

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug --output-on-failure
```

On Windows PowerShell:

```powershell
./scripts/check.ps1
```

On Linux/macOS:

```sh
./scripts/check.sh
```

## Ownership Rules

- Public GLDiagram APIs belong in `include/gldiagram/`.
- Private implementation helpers belong in `src/gldiagram/`.
- Keep vendored GLAD, KHR, and Nuklear code out of project refactors unless the
  change is explicitly about dependency maintenance.
- Tests should cover behavior, not accidental implementation details.
- Keep CMake target dependencies narrow.
- Do not weaken warnings, tests, static analysis, or CI to make a change pass.

## Documentation

Update local docs when build commands, CMake usage, dependencies, testing
policy, release policy, security policy, or public API expectations change.
