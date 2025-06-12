# GLDiagram - OpenGL图形画布

跨平台的OpenGL图形绘制工具，支持Windows/macOS/Linux。

## 构建

### 构建要求

- **CMake** 3.15+
- **OpenGL** 4.1+

### 构建步骤

```bash
# 进入项目根目录
cd GLDiagram

# 创建独立的构建目录（与源代码分离，保持干净）
mkdir build && cd build

# 生成构建系统
cmake .. -DCMAKE_BUILD_TYPE=Release  

# 执行编译
cmake --build . --config Release

# 运行程序
./src/GLDiagram
```

### 平台特定命令

#### Windows

```bash
cmake -G "Visual Studio 17 2022" ..
msbuild GLDiagram.sln /p:Configuration=Release

```

#### macOS

```bash
cmake -G Xcode ..
xcodebuild -scheme GLDiagram -configuration Release
```

#### Linus

```bash
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j4
```

## 项目结构

```txt
GLDiagram/
├── CMakeLists.txt          # 主构建配置
├── include/                # 头文件
├── libs/					# 库文件
├── glad/glad.c
└── src/                    # 源代码
	└── main.cpp              
```