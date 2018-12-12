#!/bin/bash


srcdir=$(dirname $0)
tmpdir=${srcdir}/tmp
homedir=~
vimrcfile="${homedir}/.vimrc"
srcvimrcfile="${srcdir}/vimrc"

vimdir="${homedir}/.vim"
srcvimdir="${srcdir}/vim"
bundledir="${vimdir}/bundle"

ycm_lib_dir=${vimdir}/ycm_build

# back up vimrc and override it
test -f ${vimrcfile} && "${vimrcfile}" "${vimrcfile}.bak"
ln -sv "${srcvimrcfile}" "${vimrcfile}"
echo "deploy .vimrc done"

# update .vim
mkdir -p ${vimdir} && ln -sv ${srcvimdir}/* ${vimdir}
echo "update .vim done"

#
mkdir -pv ${bundledir}

# install plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ 0 -eq $? ]; then
  vim +PlugInstall +qall
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
