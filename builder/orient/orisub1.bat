@echo off
echo %1 >>picdata.txt
rdjpgcom -v %1 >>picdata.txt
