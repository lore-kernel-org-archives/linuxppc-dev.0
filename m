Subject: sbin/init problem
From: bharat <bharat@coraltele.com>
To: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Message-Id: <1810905.1088601425250.JavaMail.administrator@RnDserver>
Mime-Version: 1.0
Date: 30 Jun 2004 18:47:55 +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi

i am experiencing some strange problem with /sbin/init as soon as it
starts executing it starts fetching some files from NFS server the names
of files is enclosed below some fetched with
success  some ends with error
and in the end the system stops working
can anybody help me
dev/console
Warning: unable to open an initial console.
/sbin/init .
open_namei-/sbin/initST7ST8ST11ST12prepare_bin
open_namei-/lib/ld.so.1
file /sbin/init,file /sbin/init
(start_brk) 100175f4
(end_code) 10016fe8
(start_code) 10000000
(end_data) 10016fe8
(start_stack) 7fffff40
(brk) 100175f4
 Elf_INTER 30010200
  start_thread  called here
 return value  by sys_execve 0
open_namei-/etc/ld.so.preload
ERROR
open_namei-/etc/ld.so.cache
ERROR
open_namei-/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/lib/libc.so.6
open_namei-/dev/tty0
ERROR
open_namei-/dev/console
ERROR
open_namei-/dev/null
open_namei-/var/run/utmp
ERROR
open_namei-/dev/null
open_namei-/etc/inittab
returning with error
open_namei-/dev/initctlST7ST8ST11ST12
ERROR
open_namei-/dev/null
 File NAme  /etc/rc.sysinit
open_namei-/etc/rc.sysinit
open_namei-/bin/sh
 starting thread
open_namei-/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/lib/libtermcap.so.2
open_namei-/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/lib/libdl.so.2
open_namei-/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/lib/libc.so.6
open_namei-/dev/tty
open_namei-/etc/nsswitch.conf
ERROR
open_namei-/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/lib/libnss_compat.so.2
open_namei-/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/lib/libnsl.so.1
pen_namei-/etc/passwd
open_namei-/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/lib/libnss_files.so.2
open_namei-/sbin/mount
open_namei-/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/etc/localtime
ERROR
in last it try for /dev/null file three or four times and then system
goes hangs although it is responding to ping but not executing further
and not showing any shell prompt


--

YOU CAN ACHIEVE ANYTHING BY PROGRAMMING YOUR MIND-SET !

with regards
Bharat Bhushan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
