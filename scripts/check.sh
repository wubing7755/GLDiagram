#!/usr/bin/env sh
set -eu

PRESET="${1:-debug}"
ENABLE_TIDY="${2:-}"
SOURCE_FILES="$(mktemp)"
trap 'rm -f "$SOURCE_FILES"' EXIT

find include src tests \
  \( -path 'include/glad' -o -path 'include/KHR' -o -path 'include/nuklear' \) -prune -o \
  \( -name '*.c' -o -name '*.h' -o -name '*.cpp' \) -type f -print \
  | grep -v '^src/glad\.c$' \
  | grep -v '^src/gldiagram/nuklear_backend\.c$' \
  | sort > "$SOURCE_FILES"

if command -v clang-format >/dev/null 2>&1; then
  if [ -s "$SOURCE_FILES" ]; then
    xargs clang-format --dry-run --Werror < "$SOURCE_FILES"
  fi
else
  echo "Skipping clang-format: command not found."
fi

cmake --preset "$PRESET"
cmake --build --preset "$PRESET"

if [ "$ENABLE_TIDY" = "tidy" ] || [ "$ENABLE_TIDY" = "--tidy" ]; then
  if command -v clang-tidy >/dev/null 2>&1; then
    BUILD_DIR="build/$PRESET"
    GENERATED_INCLUDE_DIR="$BUILD_DIR/generated/include"
    TIDY_FILES="$(mktemp)"
    grep '\.c$' "$SOURCE_FILES" > "$TIDY_FILES" || true
    if [ -f "$BUILD_DIR/compile_commands.json" ]; then
      if [ -s "$TIDY_FILES" ]; then
        xargs clang-tidy --warnings-as-errors='*' -p "$BUILD_DIR" < "$TIDY_FILES"
      fi
    else
      if [ -s "$TIDY_FILES" ]; then
        xargs -I{} clang-tidy --warnings-as-errors='*' --extra-arg=-std=c11 {} -- -Iinclude -I"$GENERATED_INCLUDE_DIR" < "$TIDY_FILES"
      fi
    fi
    rm -f "$TIDY_FILES"
  else
    echo "Skipping clang-tidy: command not found."
  fi
fi

ctest --preset "$PRESET" --output-on-failure
