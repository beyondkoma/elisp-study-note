
#!/bin/bash
a="hello world"
echo "A is:" $a

echo $var
let  "var+=1"
echo $var
var="$[$var+1]"
echo $var
 ((var++))
echo $var
var=$(($var+1))
echo $var
var="$(expr "$var" + 1)" #不建议使用
echo $var
var="`expr "$var" + 1`" #强烈不建议使用，注意加号两边的空格，否则还是按照字符串的方式赋值,`为Esc下方的`，而不是单引号'。
echo $var

