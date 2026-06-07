[CmdletBinding()]
param(
    [string]$Preset = "debug",
    [switch]$SkipFormat,
    [switch]$EnableTidy
)

$ErrorActionPreference = "Stop"

function Invoke-CheckedCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command,

        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}

function Get-ProjectOwnedSourceFiles {
    $excludedFragments = @(
        "\include\glad\",
        "\include\KHR\",
        "\include\nuklear\",
        "\src\glad.c",
        "\src\gldiagram\nuklear_backend.c"
    )

    Get-ChildItem -Path include, src, tests -Recurse -File -Include *.c, *.h, *.cpp -ErrorAction SilentlyContinue |
        Where-Object {
            $path = $_.FullName
            $excluded = $false
            foreach ($fragment in $excludedFragments) {
                if ($path -like "*$fragment*") {
                    $excluded = $true
                    break
                }
            }
            -not $excluded
        } |
        Sort-Object FullName
}

if (-not $SkipFormat -and (Get-Command clang-format -ErrorAction SilentlyContinue)) {
    $files = @(Get-ProjectOwnedSourceFiles)
    if ($files.Count -gt 0) {
        $formatArguments = @(
            "--dry-run",
            "--Werror"
        ) + @($files | ForEach-Object { $_.FullName })
        Invoke-CheckedCommand -Command "clang-format" -Arguments $formatArguments
    }
} elseif (-not $SkipFormat) {
    Write-Host "Skipping clang-format: command not found."
}

Invoke-CheckedCommand -Command "cmake" -Arguments @("--preset", $Preset)
Invoke-CheckedCommand -Command "cmake" -Arguments @("--build", "--preset", $Preset)

if ($EnableTidy) {
    if (Get-Command clang-tidy -ErrorAction SilentlyContinue) {
        $buildDirectory = Join-Path "build" $Preset
        $compileCommands = Join-Path $buildDirectory "compile_commands.json"
        $generatedIncludeDirectory = Join-Path $buildDirectory "generated\include"
        $glfwIncludeDirectory = Join-Path $buildDirectory "_deps\glfw-src\include"
        $files = @(Get-ProjectOwnedSourceFiles | Where-Object { $_.Extension -eq ".c" })
        foreach ($file in $files) {
            if (Test-Path $compileCommands) {
                Invoke-CheckedCommand -Command "clang-tidy" -Arguments @(
                    $file.FullName,
                    "--warnings-as-errors=*",
                    "-p",
                    $buildDirectory
                )
            } else {
                Invoke-CheckedCommand -Command "clang-tidy" -Arguments @(
                    $file.FullName,
                    "--warnings-as-errors=*",
                    "--extra-arg=-std=c11",
                    "--",
                    "-Iinclude",
                    "-I$generatedIncludeDirectory",
                    "-I$glfwIncludeDirectory"
                )
            }
        }
    } else {
        Write-Host "Skipping clang-tidy: command not found."
    }
}

Invoke-CheckedCommand -Command "ctest" -Arguments @("--preset", $Preset, "--output-on-failure")
