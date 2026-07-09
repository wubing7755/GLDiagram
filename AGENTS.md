# AGENTS.md

Repository-specific instructions for AI agents.

## Required Reading

Before changing files, read:

- `CONTRIBUTING.md`
- `doc/testing.md`

For architecture-sensitive changes, also read:

- `doc/adr/README.md`
- Relevant ADR files under `doc/adr/`

For build, CI, dependency, release, or security work, also read:

- `doc/cmake-guide.md`
- `doc/build.md`
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
doc/guides/     Topic guides
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

## AI Agent Policy

AI agents may help with development when their changes are scoped, reviewed,
and verified like any other contribution.

### Appropriate Uses

- Focused bug fixes.
- Test additions.
- Documentation updates.
- Build and CI maintenance.
- Mechanical refactors that preserve behavior.

### Restricted Uses

AI agents should not independently:

- Redesign core architecture without maintainer direction.
- Weaken tests, warnings, static analysis, or CI.
- Add large dependencies or generated code without approval.
- Publish releases, rotate credentials, or change repository permissions.
- Rewrite vendored GLAD, KHR, or Nuklear code as part of unrelated work.

### Disclosure

Pull requests should disclose meaningful AI assistance: list the required docs
read, summarize what the agent did, and record the human verification performed.

### Playbooks

**General workflow:** Read AGENTS.md and relevant docs, inspect the smallest
relevant file set, make focused changes, run checks, summarize changed files,
validation, and residual risk.

**Bug fix:** Reproduce or identify the failing behavior, add a regression test
when practical, fix the smallest owning module, run targeted and broader checks.

**Refactor:** Define behavior that must remain unchanged, stay within module
boundaries, avoid mixing feature behavior with refactor work, run tests
covering touched modules.

**CI or build fix:** Inspect the failing check and logs, reproduce locally when
practical, fix the project cause rather than masking the check, keep scripts,
presets, and docs aligned.

For CMake, dependency, install, or CI work, use `doc/cmake-guide.md` to select
the relevant checks.

## Documentation

Update local docs when build commands, CMake usage, dependencies, testing policy,
release policy, security policy, or public API expectations change.
