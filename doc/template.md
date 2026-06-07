# Template Application

GLDiagram has been adapted to the local `c-project-standard` template while
remaining an application project rather than an installable library package.

## Applied

- Modular top-level CMake with `cmake/CompilerOptions.cmake`,
  `cmake/Dependencies.cmake`, `cmake/Sources.cmake`, `cmake/Tests.cmake`, and
  `cmake/Packaging.cmake`.
- `CMakePresets.json` for debug, release, sanitizer, and coverage builds.
- Generated `gldiagram/version.h` from the CMake project version.
- CTest-based automated checks that do not require a graphics session.
- Local `scripts/check.ps1` and `scripts/check.sh` wrappers.
- CI, static analysis, Dependabot, issue templates, and PR template.
- Short contributor, security, build, testing, release, and AI-agent docs.

## Trimmed

The source template's package-config and downstream package smoke tests were
not copied because GLDiagram currently ships as an application, not a public C
library. Add those pieces only if the project later exposes a stable library API.

The template's shared-library preset was also omitted because there is no
project-owned library target today.

## Naming

Template identifiers were renamed from `CPROJECT` and `cproject` to
`GLDIAGRAM` and `gldiagram` where they apply to GLDiagram-owned build logic.

Project-owned public headers belong under `include/gldiagram/`. Vendored GLAD,
KHR, and Nuklear headers keep their upstream namespaces.
