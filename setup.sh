#!/bin/bash
cd `dirname $0`
BASE_DIR=`pwd`

git submodule update --init

IGNORE_LIST=( \
    '.git' \
    '.gitignore' \
    '.gitmodules' \
    'setup.sh' \
)
function _is_ignore()
{
    for ignore in ${IGNORE_LIST[@]}; do
        if [ $1 = $ignore ]; then 
            return 1;
        fi
    done
    return 0;
}

function _link()
{
    from=$1
    to=$2
    if [ -e $2 ]; then
        echo -n "$to is already exist. do you override? (y/n)"
        read input
        if [ $input = 'y' ]; then
            mv $to /tmp/$from
            echo mv $to /tmp/$from
        else
            return
        fi
    fi
    ln -s $BASE_DIR/$from $to
    echo ln -s $BASE_DIR/$from $to
}

FILE_LIST=(`ls -a | grep -v '\.$' | perl -pe 's/\///'`)
for file in ${FILE_LIST[@]}; do
    _is_ignore $file
    if [ $? -eq 0 ]; then
        _link $file $HOME/$file
    fi
done

# EOF
