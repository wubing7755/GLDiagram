#include <gldiagram/version.h>

#include <stdio.h>

int main(void)
{
    if (GLDIAGRAM_VERSION_STRING[0] == '\0') {
        puts("GLDIAGRAM_VERSION_STRING must not be empty");
        return 1;
    }

    if (GLDIAGRAM_VERSION_MAJOR < 0 || GLDIAGRAM_VERSION_MINOR < 0 || GLDIAGRAM_VERSION_PATCH < 0) {
        puts("GLDiagram version components must be non-negative");
        return 1;
    }

    return 0;
}
