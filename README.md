# GLDiagram - OpenGLͼ�λ���

��ƽ̨��OpenGLͼ�λ��ƹ��ߣ�֧��Windows/macOS/Linux��

## ����

### ����Ҫ��

- **CMake** 3.15+
- **OpenGL** 4.1+

### ��������

```bash
# ������Ŀ��Ŀ¼
cd GLDiagram

# ���������Ĺ���Ŀ¼����Դ������룬���ָɾ���
mkdir build && cd build

# ���ɹ���ϵͳ
cmake .. -DCMAKE_BUILD_TYPE=Release  

# ִ�б���
cmake --build . --config Release

# ���г���
./src/GLDiagram
```

### ƽ̨�ض�����

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

## ��Ŀ�ṹ

```txt
GLDiagram/
������ CMakeLists.txt          # ����������
������ include/                # ͷ�ļ�
������ libs/					# ���ļ�
������ glad/glad.c
������ src/                    # Դ����
	������ main.cpp              
```