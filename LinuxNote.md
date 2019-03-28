# Linux学习笔记 (Linux里面一切都是文件) 
   
## 1.Linux专门提供了tree命令。
       查看树型层次结构  tree /home  tree /
## 2. /  
       表示Linux系统的根目录
## 3.绝对路径和相对路径
       pwd 命令  打印当前工作目录  这个目录就是绝对路径
       相对路径就是相对于当前路径而言，就是一个路径从当前路径算起，应该怎么走
       Linux中相对路径有四中表示方法，分别为 .| ..| ~user| ~
       .表示当前路径  ..表示父路径  ~user表示某个用户的主目录 其中user表示用户账号，~表示当前用户的主目录  
## 4.Linux对大小写敏感
## 5.cd 表示该表当前的工作目录
## 6.tree / -L 1  当前系统中根目录下的所有目录
## 7.cat命令来输出某个文件中内容
## 8.ll查看文件的类型
## 9.file查看文件的具体类型  ELF表示可执行文件
## 10.Linux把目录也看成一种文件   ll命令显示的结果中  目录文件的第一个字符为d
        ll /etc|grep '^d'     |表示匿名管道  就是讲ll命令的输出结果输出入到后面的命令。
        grep命令用来对ll的输出结果进行筛选，而^d则是一个正则表达式，表示一字符d开始的文本。
        file命令也可以用来判断是否为文件目录
        file /etc/*    文件目录输出为  directory	
## 11.ll命令中。字符设备的标识为c
        ll /dev|grep '^c'     输出   crw-r--r--
        在比如使用file命令  file /dev/tty      输出  /dev/tty: character special (5/0)  文件为字符特殊文件
## 12.块设备文件  ll /dev|grep '^b'  文件类型为b
        sda 为当前系统中连接的第一块磁盘，sda1，sda2等等分别为sda上面的分区。sr0为光驱，光盘也属于块设备文件。
        使用file命令 file /dev/sda  输出 /dev/sda: block special (8/0)
## 13管道  所谓管道，是Linux系统中讲一个进程的输出连接到另一个进程的输入，从而允许进程间通信的文件。
        可以简单的理解，管道的作用就是充当两个进程见数据交换的通道。可以为Linux系统中需要通信的两个进程比作两段断开的水管，
        现在需要将一段水管中的水引入到另一个水管中，为了达到这个目的需要一段中间的转接水管，而管道就承担了这个角色。
        Linux中的管道文件有两种类型，分别为匿名管道和命令管道。
      1.匿名管道使用|符号表示，通常情况下，它用来连接两个命令。
        ps -ef | grep mysql  （意思就是查找当前系统中是否存在包含mysql关键字的进程，这个命令可以帮助查看Mysql
        Server是否运行）
        ps -ef表示列出当前系统中的进程  grep mysql  就是用来匹配指定的字符串
        ll /etc | more   ll命令的输出结果传给more后，如果输出结果超过一屏，则会在屏幕底部显示一个“更多”字样，通过空格继续查看。

      2.命名管道
        ll /run/systemd/initctl/   输出结果中  fifo为一个命名管道文件，其文件类型为p
        file命令  file /run/systemd/initctl/fifo  输出  /run/systemd/initctl/fifo: fifo (named pipe)
        命名管道的两种创建方法
        1.在Shell下通过命令交互创建命名管道
          在Shell下用户可以通过2个命令创建命名管道文件名，分别为mknod和mkfifo
          mknod命令  mknod fifo p   fifo表示要创建的文件名  p表示文件类型是管道文件
          mkfifo命令  mkfifo fifo  这里直接写上文件名就行
        2.在程序中通过调用系统函数创建命名管道
          为了便于编程  Linux提供mkfifo()函数来创建命名管道文件
          函数原型  int  mkfifo(const char *pathname,mode_t mode);
          其中pathname为命名管道文件的文件名，mode为文件的访问权限，该函数返回值为整型。
## 14.套接字
         通过套接字能使通过网络连接的不同计算机的进程之间通信。这就是说，套接字可以运行网络上不同机器中的
         进程提供数据和信息传输。套接字文件以字母s标识。
         ll /run/mysqld/  与管道一样，套接字文件也不与任何数据块关联。
## 15.文件链接 所谓链接，是对文件的引用。
         1.符号链接（软链接  类似于一个指针，指向文件在文件系统中的具体位置，可以跨文件系统指向远程的文件系统中的文件）
           ll /bin   输出ypdomainname -> hostname*  就为符号链接  有箭头指向了原始文件。
           file命令  file /bin/bzcmp    输出  /bin/bzcmp: symbolic link to bzdiff
           上面的结果明确告诉我们， /bin/bzcmp是一个指向bzdiff的符号链接。
         2.硬链接（是同一个文件系统中同一个文件的一个或者多个别名）硬链接直接指向文件的实际数据在磁盘上面的存储位置。
## 16.rm 文件名  删除文件
## 17.文件权限
         1.基本权限  分为三个权限组  文件所有者（u文件的创建者，拥有全部权限）、文件所属组（g某个用户对该文件拥有访问权限）、其他用户（o其他用户对文            件的访问权限）,所有用户 a
           对每个文件或者目录，有三种基本权限类型，分别为读，写和执行。r  w  x  如果没有该种权限则用连字符-表示。
         Linux还支持一种二进制数字表示法，即分别用二进制100,010,001表示，十进制就是4，2，1
         2.特殊权限 三种特殊权限，分别是setuid,setgid和黏滞位。前面两种用s表示。十进制  4   2
           前面两种是为了是某个程序执行时能够得到权限提升而设置。而后者则是为了保护文件目录不被他人删除而设置。
           setuid set user ID upon execution  设置文件所有者的id，即使是别的用户操作文件，也被认为是文件所有者在操作。
           setgid set gruop ID upon execution 设置文件所在组的地id
           这两种权限就是在执行某个特殊任务时候，需要任务执行者的权限得到临时提升。
           比如 、/etc/passwd（用来存储账号信息）和/etc/shadow（存储密码信息）是两个非常关键的文件。都为root用户才有写入
           的权限。但是Linux中每个用户都可以通过passwd命令修改自己的密码信息。有些非root用户可以在Linux系统中增加或者删
           除账号。Linux系统为passwd命令设置了该权限，并且讲passwd命令所有者设置为root。因此别的用户也可以修改这两个文件。
           黏滞位（t表示，数字为1）与上面两种作用恰恰相反，/tmp目录是Linux为所有应用程序提供的临时目录。这个目录对所有用户来说都是可度，可写的。
         3.显示文件权限
          ls -l 文件路径
          举例  ls -l /ect/passwd       输出  -rw-r--r-- 文件所有者的权限rw  文件所在组的访问权限  r   其他用户 r
               ls -l /usr/bin/passwd   输出  -rwsr-xr-x 文件所有者的权限rws  文件所在组的访问权限  xr   其他用户 r
               上面出现的s权限即为setuid 它占用的是所有者权限的第三个字符(也即是x所在位置)
               而setgid是文件所在组权限的第三个字符。同样是x字符的位置。
               如果是setuid或者setgid和x权限同时拥有，则会将两种权限叠加，用小写的字符s表示。
               如果只设置了setuid或者setgid权限。没有x权限，则用大写S表示。
               ls -l /                输出  drwxrwxrwt  14 root root  4096 3月  28 10:18 tmp 
               上面/tmp文件的权限的最后一组为rwt,即设置了黏滞位。
               黏滞位占用其他用户权限的第三个字符，即x位置。同样如果同时设置了黏滞位和执行权限x，则用小写t表示，
               否则只设置了黏滞位，没有执行权限x，则用大写T表示。
         4.修改文件权限
               chmod [option]...permission [,permission]...file...
               option表示命令选项   -R  --recursive (该选项表示递归修改文件的权限，就是与他相关的所有文件都将被修改)
               permission参数表示文件的权限。（字符串或数值表示）  +增加权限  -删除权限
              1）字符方式修改权限
                 mkdir -p dir1/dir2/dir3创建目录   mkdir表示创建目录  -p 如果父目录不存在。则创建父目录
                 touch file   创建一个空白文件。
                 ls -l显示dir1的权限  drwxr-xr-x 下面通过chmod命令讲dir1的访问权限设置为所在组可写。
                 chmod g+w dir1  执行完后再查看 drwxrwxr-x
                 chmod g+w dir1  将前面增加的权限删除 再查看   drwxr-xr-x
                 用户可以修改多个权限组
                 chmod g+w,o+w dir1   drwxrwxrwx
                 多个权限也可以组合
                 chmod g+w-r,o-w dir1   drwx-wxr-x
                 上面的操作不会影响子目录下面的文件权限
              2）数字方式修改权限
                 第一位表示所有者权限，第二位表示所在组权限，第三位表示其他用户权限，每位十进制书都是三种权限数值的和。
                 例如7表示文件可读，可写，可执行。7=4+2+1
                （注意，切忌将关键文件的权限为了方便设置为777，这将引起安全隐患）
                 关于设置setuid和setgid以及黏滞位字符方式同理。但是如果是使用数字方式，只需要将数字置于最高位即可，将会
                 形成4位数字 4751 4就是setuid权限  首位是特殊权限的数字  后面三位是普通权限）
         5.更改文件所有权
              查看文件的所有权  ls -l  第三列为文件的所有者 第四列为文件的所属组
              chown命令更改文件的所有权
              chown [option]...[owner][:[group]] file...
              option表示命令选项   -R  --recursive (该选项表示递归修改文件的权限，就是与他相关的所有文件都将被修改)
              owner文件新的所有者 必须是系统中已经存在的有效账号 
              group文件的所属组，要是为空，意味着只更改文件的所有者，否则同时更改。
              sudo chown root dir1  这里将dir1文件的所有者改成root
              sudo命令用来以root用户的身份来执行某个命令
              sudo chown root:root dir1 

[内容持续更新中，敬请期待...](https://github.com/zixi5534/LinuxAndJavaNote/blob/master/LinuxNote.md)
