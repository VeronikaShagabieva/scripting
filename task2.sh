#!/bin/bash

while getopts "d:n:" option
do
  case $option in
    n ) name="$OPTARG";; #name — это название самораспаковывающегося архива, обязательный параметр
    d ) dir_path="$OPTARG";; # dir_path — это путь к каталогу содержимое которого нужно упаковать, обязательный параметр
  esac
done

arch=$(tar -cz $dir_path | base64)

echo "#!/bin/bash
arch=\"$arch\"
while getopts \"o:\" opt 
do
    case \$opt in
    o ) unpackdir="\$OPTARG";;
    esac
done
if [ \$unpackdir ]
then
    echo \"\$arch\" | base64 --decode | tar -xvz -C \$unpackdir
else
    echo \"\$arch\" | base64 --decode | tar -xvz 
fi" > $name.sh

chmod 4555 $name.sh #право исполнения: каждый пользователь имеет право читать и запускать на выполнение с правами владельца файла
