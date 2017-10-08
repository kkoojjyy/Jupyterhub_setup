# Jupyterhub设置

本文档提供几个用来方便地部署jupyterhub的工具，共有5个shell script组成，依次是，sysdeps.sh、conda.sh、useradd.sh、jupyterconf.sh、nbgrader.sh.

顺序执行各个shell script，并且在执行完后，查看是否生效，即可搭建好一个拥有功能完善的jupyterhub server。另外，要直接使用这些工具，假定你使用的是ubuntu 16.04 系统，并且能够访问并使用apt-get、conda这些工具，若是无法连接，或许使用第三方的镜像可以解决这个问题。



## 安装System dependencies

使用apt-get安装jupyterhub和conda需要的依赖项，cd 进入jupyterhub-setup，`bash sysdeps.sh` 即可。

其中，libsm6 libxrender1 libfontconfig1 build-essential gcc-multilib npm nodejs-legacy 是jupyterhub的依赖项，pandoc dvipng 和texlive用来解决将ipnb转换成pdf或者其他格式的问题。configurable-http-proxy 是一个 node-http-proxy的wrapper，也是jupyterhub的一部分。

另外，在此创建一个空白的notebook文件夹，到时将这个文件夹分配到各个用户的home里，作为jupyterhub的工作路径。

## 安装Anaconda

依旧，cd进入jupyterhub-setup，`bash conda.sh`即可。



从[Anaconda](https://www.anaconda.com/download/#linux)下载最新的linux版本并安装，在安装过程中，会问是否使用默认路径，由于默认路径普通用户无法访问，所以需要**手动指定保存路径 /opt/anaconda3**。另外，系统会问是否将anaconda加入PATH，为了所有用户都能使用conda，这里**先选择否，之后在shell script会修改全局PATH**。

```
# echo 'export PATH=/opt/anaconda3/bin:$PATH' > /etc/profile.d/anaconda.sh
# source /etc/profile.d/anaconda.sh
```

另外，需要创建独立的python2和python3环境，并将其加入到jupyter kernel里，jupyter kernel的配置文件已经写好，只需要要把它们移到指定路径即可。

```
# Create Virtual Env of python 2.7 and python 3.6
conda create -n py27 python=2.7 ipykernel
conda create -n py36 python=3.6 ipykernel

# Add python env into jupyter kernel
cp -r kernels/python2 /opt/anaconda3/share/jupyter/kernels/
cp -r kernels/python3 /opt/anaconda3/share/jupyter/kernels/
```



## 为系统创建用户

同样，cd进入jupyterhub-setup，`bash useradd.sh`即可。

因为jupyterhub默认使用PAM authenticator，且学生们可以会使用到Terminal，需要为用户在系统上创建用户。用户分为两类，lecturers和students，其中students分为py2017a 和py2017b 分别是python 的 1、2班。lecturers有sudo权限，students没有。在data/中的 lecturers.list、pya.list和pyb.list中分别给出了用户名和随机密码，这个密码只是初始密码，后面学生可以自行修改。学生的用户名的格式是“班级”+“学号”，如“pya1231800041”，指的是python1的学号为1231800041的同学。

在这一步完成后，需要检查用户创建是否生效，

`cat \etc\shadow`

查看在系统中是否创建了ryan、eric和以pya和pyb开头的学生账户。

cd进入\home

`cd \home`

查看是否为用户创建了working directory。



另外，若是创建用户过程中出现错误，可以使用`bash userdel.sh` undo 所有 useradd的操作。

## Jupyterhub 配置

如上，cd进入jupyterhub-setup，`bash jupyterconf.sh`即可。

首先使用pip安装jupyterhub，并创建各个配置文件，文件组织方式如下

1. jupyterhub 配置文件在 /etc/jupyterhub/jupyterhub.py
2. cookie_secret  jupyterhub.sqlite 放在 /srv/jupyterhub/
3. log file放在/var/log/jupyterhub.log

创建完毕后，限定访问权限。将lectureres用户加入jupyterhub的admin用户组里。

另外，将jupyterhub加入Systemd Service 以方便管理。

设置完毕后，即可用`systemctl start/stop/status jupyterhub` 来管理jupyterhub server。



## nbgrader配置

如上，cd进入jupyterhub-setup，`bash nbgrader.sh`即可。

首先创建一个文件夹作为nbgrader分配文件的路径，此路径要求所有用户都有读写的权限。

然后，安装nbgrader。默认的情况下，nbgrader为所有用户安装，但是我们不希望用户能够接触到assignment的管理，create_assignment 和 formgrader 将被disable。 每个lecturers用户需要自己另外enable这两个module。

```
# jupyter nbextension disable --user create_assignment/main
# jupyter nbextension disable --user formgrader/main --section=tree
# jupyter serverextension disable --user nbgrader.server_extensions.formgrader
```

