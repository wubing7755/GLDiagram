# Contributing

This project uses focused, reviewable changes.

## Local Checks

See `doc/cmake-guide.md` for configure, build, test, install, and
troubleshooting details.

```sh
./scripts/check.sh
```

On Windows PowerShell:

```powershell
./scripts/check.ps1
```

Or run CMake directly:

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug --output-on-failure
```

## Branches

Use short branch names:

- `feature/<topic>`
- `fix/<topic>`
- `refactor/<topic>`
- `infra/<topic>`
- `release/<version>`

## Commits And PRs

Use Conventional Commit style where practical:

```text
fix(render): clamp viewport size
feat(ui): add node palette
refactor(build): split dependency setup
```

Before opening a PR:

- Run the smallest local checks that cover the change.
- Fill in the PR template sections that apply to the change.
- Explain behavioral, compatibility, or release impact.
- Add tests for behavior changes where practical.
- Document manual GUI checks for behavior that requires a graphics session.
- Link to updated docs when the change affects build, test, release, security,
  dependency, or public API behavior.
- Keep unrelated cleanup out of feature or fix PRs.

Use the issue templates for bug reports, feature proposals, and infrastructure
maintenance requests.

## Architecture

- Keep project-owned public headers small and stable.
- Keep implementation details out of `include/`.
- Keep third-party implementation code isolated from project warnings.
- Prefer explicit ownership and cleanup paths.
- Avoid adding abstractions until repeated use justifies them.
