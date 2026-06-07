# Security Policy

## Reporting

Report vulnerabilities privately to the project maintainer. Do not open public
issues for exploitable security bugs until a fix is available.

## Supported Versions

The default policy is to support the current `main` branch unless the project
publishes versioned releases with a separate support table.

## Dependency Handling

- Prefer small, well-maintained dependencies.
- Document dependency sources and update procedures.
- Use Dependabot or an equivalent process for GitHub Actions updates.
- Do not vendor large dependencies without maintainer approval.
- Run relevant tests after dependency updates.

GLFW is fetched by CMake. GLAD and Nuklear are vendored source/header assets;
update them intentionally and record the generation or upstream version in the
PR.
