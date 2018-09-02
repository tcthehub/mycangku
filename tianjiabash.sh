#!/bin/bash
#自动为其他脚本添加解释器信息#!/bin/bash
#先使用grep判断对象脚本是否已经有解释器信息，如果没有则使用sed添加解释器以及描述信息
if ! grep -q "^#!"  $1 ;then
sed -i '1i #!/bin/bash' $1
sed -i '2i #Description' $1
fi
#因为每个脚本的功能不同，作用不同，所以在给对象脚本添加完解释器信息，以及Description后还希望继续编辑具体的脚本功能的描述信息，这里直接使用vim把对象脚本打开，并且光标跳转到该文件的第二行
vim +2 $1
