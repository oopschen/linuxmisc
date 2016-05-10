#!/bin/bash


srcdir=$(dirname $0)
tmpdir=${srcdir}/tmp
homedir=~
vimrcfile="${homedir}/.vimrc"
srcvimrcfile="${srcdir}/vimrc"

vimdir="${homedir}/.vim"
srcvimdir="${srcdir}/vim"
bundledir="${vimdir}/bundle"
vundlefile=${bundledir}/Vundle.vim

ycm_lib_dir=${vimdir}/ycm_build

# back up vimrc and override it
test -f ${vimrcfile} && "${vimrcfile}" "${vimrcfile}.bak"
cp "${srcvimrcfile}" "${vimrcfile}"
echo "deploy .vimrc done"

# update .vim
mkdir -p ${vimdir} && cp -r -u ${srcvimdir}/* ${vimdir}
echo "update .vim done"

# 
mkdir -pv ${bundledir}

# install vundle
# vundle install and update
if [ ! -d ${vundlefile} ]; then
  git clone https://github.com/gmarik/Vundle.vim.git ${vundlefile}
  vim +PluginInstall +qall
else
  vim +PluginUpdate +qall
fi


# YCM plugin config
if [ -d ${bundledir}/YouCompleteMe ]; then
  rm -rf ${ycm_lib_dir}
  mkdir ${ycm_lib_dir}
  curdir=$(realpath $(pwd))

  cd ${ycm_lib_dir}
  cmake -D USE_SYSTEM_LIBCLANG=ON -G "Unix Makefiles" . ${bundledir}/YouCompleteMe/third_party/ycmd/cpp
  cmake --build . --target ycm_core --config Release

  cd ${curdir}
fi

# end
