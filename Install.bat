@echo off
set FNAME=.dein.toml
set FNAME2=.vimrc

set TARGET_DIR=%homedrive%%homepath%
echo ##########################################################################
echo file name  : %FNAME%
echo file name  : %FNAME2%
echo target dir : %TARGET_DIR%
echo #######################################################################

copy /Y %FNAME%  %TARGET_DIR%\%FNAME%
copy /Y %FNAME2%  %TARGET_DIR%\%FNAME2%
pause
