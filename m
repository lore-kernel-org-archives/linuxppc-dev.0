Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <3Q989092894158.07376@webmail4.inner-21cn.com>
Date: Fri, 7 Sep 2001 10:58:41 +0800 (CST)
From: "yah" <hay8888@21cn.com>
To: jari.nguyen@smartstors.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: shared libraries
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.
  I use MCP750,HHL1.2, and create a ramdisk to boot the board . When booting,it said

Linux/PPC load: root=/dev/ram0 init=/bin/bash
Uncompressing Linux...done.
Now booting the kernel
<snip>
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194302k freed
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 128k init 20k pmac 4k chrp 4k openfirmware
initKernel panic: Attempted to kill init!
: error in loading shared libraries: libtermcap.Rebooting in 180 seconds..so.2:y

  I found libtermcap.so.2 and libtermcap.so.2.0.8 are in ...7xx/target/lib, and files list follow are all there. I found the files in .../7xx/powerpc-hardhat-linux/lib are almost in .../target/lib except some *.a files. Should I still link .../7xx/powerpc-hardhat-linux to .../7xx/target?

/lib
-rwxr-xr-x 1 root root 93544 Sep 29 08:56 ld-2.1.3.so
lrwxrwxrwx 1 root root 11 Oct 3 14:54 ld.so.1 -> ld-2.1.3.so

-rwxr-xr-x 1 root root 1052892 Sep 29 08:51 libc-2.1.3.so
lrwxrwxrwx 1 root root 13 Oct 3 14:54 libc.so.6 ->
libc-2.1.3.so
-rwxr-xr-x 1 root root 11372 Sep 29 08:56 libdl-2.1.3.so
lrwxrwxrwx 1 root root 10 Oct 3 14:54 libdl.so -> libdl.so.2

lrwxrwxrwx 1 root root 14 Oct 3 14:54 libdl.so.2 ->
libdl-2.1.3.so
-rwxr-xr-x 1 root root 40268 Sep 27 07:57 libnss_files-2.1.3.so
lrwxrwxrwx 1 root root 17 Oct 3 14:54 libnss_files.so ->
libnss_files.so.2
lrwxrwxrwx 1 root root 21 Oct 3 14:54 libnss_files.so.2 ->
libnss_files-2.1.3.so
lrwxrwxrwx 1 root root 19 Oct 3 14:54 libtermcap.so ->
libtermcap.so.2.0.8
lrwxrwxrwx 1 root root 19 Oct 3 14:54 libtermcap.so.2 ->
libtermcap.so.2.0.8
-rwxr-xr-x 1 root root 13832 Sep 29 08:56 libtermcap.so.2.0.8

   Thanks for any replies.

Regard,
Amy
------------------------------------------------
"世纪邮箱，惊奇之旅"------奖品送不停
http://mail.21cn.com/promotion/828/index.html
100元上21cn，做分类广告
http://adinfo.21cn.com/price/001.html
携手合作，诚征代理
http://mail.21cn.com/business/005.html
眼光的较量，20万巨奖等你拿
http://10games.21cn.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
