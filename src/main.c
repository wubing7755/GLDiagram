#include <stdio.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>

#define NK_INCLUDE_FIXED_TYPES
#define NK_INCLUDE_STANDARD_IO
#define NK_INCLUDE_STANDARD_VARARGS
#define NK_INCLUDE_DEFAULT_ALLOCATOR
#define NK_INCLUDE_VERTEX_BUFFER_OUTPUT
#define NK_INCLUDE_FONT_BAKING
#define NK_INCLUDE_DEFAULT_FONT

#define NK_IMPLEMENTATION
#define NK_GLFW_GL3_IMPLEMENTATION

#include <nuklear/nuklear.h>
#include <nuklear/nuklear_glfw_gl3.h>

#define WINDOW_WIDTH 800
#define WINDOW_HEIGHT 600
#define MAX_VERTEX_BUFFER 512 * 1024
#define MAX_ELEMENT_BUFFER 128 * 1024

static struct nk_glfw glfw_ctx;
static struct nk_context *ctx;

void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    glViewport(0, 0, width, height);
}

int main(void)
{
    if (!glfwInit())
    {
        printf("Failed to initialize GLFW\n");
        return -1;
    }

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    GLFWwindow* window = glfwCreateWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "GLDiagram - Nuklear GUI", NULL, NULL);
    if (!window)
    {
        printf("Failed to create window\n");
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        printf("Failed to init GLAD\n");
        return -1;
    }

    printf("OpenGL: %s\n", glGetString(GL_VERSION));

    /* 初始化 Nuklear */
    ctx = nk_glfw3_init(&glfw_ctx, window, NK_GLFW3_INSTALL_CALLBACKS);

    struct nk_font_atlas *atlas;
    nk_glfw3_font_stash_begin(&glfw_ctx, &atlas);
    nk_glfw3_font_stash_end(&glfw_ctx);

    while (!glfwWindowShouldClose(window))
    {
        glfwPollEvents();
        nk_glfw3_new_frame(&glfw_ctx);

        if (nk_begin(ctx, "Show",
            nk_rect(50, 50, 220, 220),
            NK_WINDOW_BORDER|NK_WINDOW_MOVABLE|NK_WINDOW_CLOSABLE))
        {
            nk_layout_row_static(ctx, 30, 100, 1);

            if (nk_button_label(ctx, "Click Me"))
            {
                printf("Button clicked\n");
            }
        }

        nk_end(ctx);

        glClear(GL_COLOR_BUFFER_BIT);

        nk_glfw3_render(&glfw_ctx, NK_ANTI_ALIASING_ON,
                        MAX_VERTEX_BUFFER, MAX_ELEMENT_BUFFER);

        glfwSwapBuffers(window);
    }

    nk_glfw3_shutdown(&glfw_ctx);

    glfwTerminate();
    return 0;
}