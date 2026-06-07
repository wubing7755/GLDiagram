#include <gldiagram/version.h>

#include <stdio.h>

int main(void) {
    if (GLDIAGRAM_VERSION_STRING[0] == '\0') {
        puts("GLDIAGRAM_VERSION_STRING must not be empty");
        return 1;
    }

    printf("GLDiagram %d.%d.%d\n", GLDIAGRAM_VERSION_MAJOR, GLDIAGRAM_VERSION_MINOR,
           GLDIAGRAM_VERSION_PATCH);

    return 0;
}
