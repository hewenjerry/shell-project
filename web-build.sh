#!/bin/sh


set -e

HOME_DIR=/data/script
BUILD_DIR=/data/build

BRANCH=master;

if [ $1 ]
then
    PROJECT_NAME=$1;
else
    echo "请输入project name:("
    exit
fi

if [ $2 ]
then
        BRANCH=$2;
fi
if [ -e ${HOME_DIR}'/lockJava' ]
then
        echo "有人在搞飞机，歇会儿再踹"
        cat ${HOME_DIR}/lockJava
        exit
else
        echo 开始部署${PROJECT_NAME}，分支[${BRANCH}]...
        echo 『$SSH_CLIENT』 正在部署${PROJECT_NAME} > ${HOME_DIR}/lockJava
        echo 部署分支:${BRANCH} >> ${HOME_DIR}/lockJava
fi

export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

if [ -e ${BUILD_DIR} ]
then
        #已经存在不用创建了
        echo data_java已经存在.
else
        mkdir -p ${BUILD_DIR}
fi

REPOS_DIR=${BUILD_DIR}/${PROJECT_NAME}-repos

echo 准备工作空间
rm -rf ${REPOS_DIR}
/usr/local/bin/git clone -b master git@git.s.hehua.com:${PROJECT_NAME}.git ${REPOS_DIR}

echo maven编译
cd ${REPOS_DIR}

mvn clean -Pproduct compile war:exploded -U -Dmaven.test.skip=true -T 2.0C

TARGET_DIR=${BUILD_DIR}/${PROJECT_NAME}
echo 目标目录:${TARGET_DIR}

if [ -e ${TARGET_DIR} ]
then
        #已经存在不用创建了
        echo ${TARGET_DIR}已经存在.
else
        mkdir -p ${TARGET_DIR}
fi

#rsync -ztrlvC --delete ${REPOS_DIR}/target/${PROJECT_NAME}/ ${TARGET_DIR}/
rsync -ztrlvC --delete ${REPOS_DIR}/target/${PROJECT_NAME}-1.0-SNAPSHOT/ ${TARGET_DIR}/

echo 解锁
rm -f ${HOME_DIR}/lockJava
