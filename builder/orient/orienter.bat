@echo off
REM Batch File to Read JPG header info from
REM all .jpg in all single letter subdirectories
REM of parent directory of current directory.
ECHO.
ECHO ORIENTER Version 2.0
ECHO.
ECHO Collects picture oriention data from your area subdirectories.
ECHO.
ECHO.

ECHO Collecting data from sub-directory a
FOR %%I IN ("..\a\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory b
FOR %%I IN ("..\b\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory c
FOR %%I IN ("..\c\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory d
FOR %%I IN ("..\d\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory e
FOR %%I IN ("..\e\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory f
FOR %%I IN ("..\f\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory g
FOR %%I IN ("..\g\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory h
FOR %%I IN ("..\h\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory i
FOR %%I IN ("..\i\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory j
FOR %%I IN ("..\j\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory k
FOR %%I IN ("..\k\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory l
FOR %%I IN ("..\l\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory m
FOR %%I IN ("..\m\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory n
FOR %%I IN ("..\n\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory o
FOR %%I IN ("..\o\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory p
FOR %%I IN ("..\p\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory q
FOR %%I IN ("..\q\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory r
FOR %%I IN ("..\r\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory s
FOR %%I IN ("..\s\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory t
FOR %%I IN ("..\t\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory u
FOR %%I IN ("..\u\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory v
FOR %%I IN ("..\v\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory w
FOR %%I IN ("..\w\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory x
FOR %%I IN ("..\x\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory y
FOR %%I IN ("..\y\*.jpg") DO CALL orisub1.bat %%I
ECHO Collecting data from sub-directory z
FOR %%I IN ("..\z\*.jpg") DO CALL orisub1.bat %%I

ECHO.
ECHO Compacting collected data
ECHO.
ORISUB2
ERASE picdata.txt
ECHO.

ECHO Incorporating any magnified images found
ECHO.
ORIMAG
ERASE orient.txt
REN orientm.txt orient.txt
ECHO.

ECHO Process finished and ORIENT.TXT produced
ECHO.
ECHO.

