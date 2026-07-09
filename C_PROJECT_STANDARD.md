# C Project Standard

This document defines a pragmatic baseline for small and medium C projects.

## Contents

- [Core Principles](#core-principles)
- [Required Project Shape](#required-project-shape)
- [CMake Standard](#cmake-standard)
- [Testing Standard](#testing-standard)
- [Header Boundary Standard](#header-boundary-standard)
- [CI Standard](#ci-standard)
- [Repository Maintenance Standard](#repository-maintenance-standard)
- [Documentation Standard](#documentation-standard)
- [Avoid By Default](#avoid-by-default)

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
doc/guides/          Topic guides
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

Language and toolchain policy should be explicit:

- Set the project language standard in CMake as a target-level requirement, such
  as `target_compile_features(<target> PUBLIC c_std_11)`.
- Use C11 as the default baseline for portable C libraries unless the project
  documents a reason to require a newer standard.
- Support compiler families rather than one exact local compiler path: MSVC,
  GCC, Clang, and AppleClang are the normal baseline.
- Keep committed presets generator-neutral unless a preset exists specifically
  to document a generator-dependent workflow.
- Keep compiler installation paths, SDK paths, and developer-specific CMake kits
  in user presets or local IDE configuration, not in shared project files.
- Document which tools users must install and which tools are optional editor
  conveniences.

Recommended presets for this application:

- `debug`
- `release`
- `asan`
- `coverage`

## Testing Standard

- Use CTest as the universal test runner.
- Prefer focused test executables per module or subsystem.
- Do not test implementation details unless the detail is a documented internal
  contract.
- Bug fixes should include a regression test unless the behavior is only
  observable manually.
- Do not launch the interactive OpenGL window in automated CI tests.

## Header Boundary Standard

Public:

```text
include/<project>/feature.h
```

Internal:

```text
src/<project>/feature_internal.h
```

Rules:

- Public headers should include only what they need.
- Public types should be stable and documented.
- Internal headers may expose implementation state but must stay out of public
  consumers.

## CI Standard

Every project should have:

- Debug build and tests across supported compiler families (MSVC, GCC, Clang,
  AppleClang).
- Release build and tests.
- Sanitizer build where supported.
- Static analysis using at least `cppcheck`.
- clang-tidy when a project provides a `.clang-tidy` configuration.
- YAML linting for workflow and automation files.
- Coverage preset validation for projects that provide a coverage preset.

## Repository Maintenance Standard

Templates should include lightweight PR and issue templates when the repository
expects external or AI-assisted contributions. GitHub Actions dependencies
should be covered by Dependabot or an equivalent documented update process.

## Documentation Standard

Keep local docs short:

- `README.md` for overview and quick start.
- `CONTRIBUTING.md` for workflow and PR expectations.
- `SECURITY.md` for vulnerability handling.
- `doc/README.md` for the documentation map and source-of-truth index.
- `doc/guides/environment.md` for tool installation and environment setup.
- `doc/cmake-guide.md` for CMake workflows, presets, and troubleshooting.
- `doc/build.md` for the concise build reference.
- `doc/testing.md` for test layers and expectations.
- `doc/release.md` for release steps.
- `doc/template.md` for how the template was applied and trim notes.
- `doc/guides/ai-agent.md` for AI-assisted contribution rules (redirects to
  AGENTS.md).
- `doc/adr/README.md` for architecture decisions.
- `AGENTS.md` for AI-agent instructions.

## Avoid By Default

Do not add these early unless the project already needs them:

- Plugin registries.
- Descriptor manifests.
- Multi-stage command dispatch systems.
- Global service locator objects.
- Generated code beyond the version header.
- Large vendored dependencies.

Use the smallest design that keeps ownership clear.
