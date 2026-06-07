# C Project Standard

This document defines the baseline used by this repository after applying the
`c-project-standard` template.

## Core Principles

- Start simple and keep ownership visible.
- Put public project APIs in `include/<project>/`; keep implementation details
  in `src/`.
- Keep third-party and generated code isolated from project warnings and static
  analysis.
- Make build, test, and CI reliable from the first commit.
- Keep documentation short, local, and tied to contributor decisions.

## Required Project Shape

```text
include/<project>/   Public project headers
src/<project>/       Project implementation
src/main.c           Application entry point
tests/               Focused CTest tests
cmake/               CMake modules
scripts/             Local check wrappers
doc/                 Short documentation
.github/workflows/   CI
```

## CMake Standard

Use a small top-level `CMakeLists.txt` that delegates to modules:

- `cmake/CompilerOptions.cmake` for warnings, sanitizers, and coverage.
- `cmake/Dependencies.cmake` for third-party dependencies.
- `cmake/Sources.cmake` for source lists.
- `cmake/Tests.cmake` for test targets.
- `cmake/Packaging.cmake` for install rules.

Top-level-only conveniences such as app builds, tests, and install rules should
default to on for normal repository builds and off when the project is included
as a subproject.

Recommended presets for this application:

- `debug`
- `release`
- `asan`
- `coverage`

## Testing Standard

- Use CTest as the universal automated test runner.
- Prefer focused test executables per module or subsystem.
- Do not run the interactive OpenGL window as an automated CI test.
- Bug fixes should include a regression test unless the behavior is only
  observable manually.
- Document manual GUI checks in PRs when relevant.

## Header Boundary Standard

Public project headers belong under:

```text
include/gldiagram/
```

Internal implementation files belong under:

```text
src/gldiagram/
```

Vendored or generated headers such as GLAD, KHR, and Nuklear stay under their
own include namespaces and should not be treated as GLDiagram public API.

## CI Standard

Every project should have:

- Debug build and tests.
- Release build and tests.
- Sanitizer validation where supported.
- Static analysis using at least `cppcheck`.
- clang-tidy when a project provides a `.clang-tidy` configuration.
- YAML linting for workflow and automation files.
- Coverage preset validation when a coverage preset is provided.

## Documentation Standard

Keep local docs short:

- `README.md` for overview and quick start.
- `CONTRIBUTING.md` for workflow and PR expectations.
- `SECURITY.md` for vulnerability handling.
- `doc/cmake-guide.md` for CMake workflows and troubleshooting.
- `doc/build.md` for build details.
- `doc/testing.md` for test layers and expectations.
- `doc/release.md` for release steps.
- `doc/template.md` for how the template was applied.
- `doc/adr/README.md` for architecture decisions.
- `AGENTS.md` for AI-agent instructions.

## Avoid By Default

Do not add these early unless the project already needs them:

- Plugin registries.
- Descriptor manifests.
- Multi-stage command dispatch systems.
- Global service locator objects.
- Generated code beyond tightly scoped build metadata or OpenGL loader output.
- Large vendored dependencies.

Use the smallest design that keeps ownership clear.
