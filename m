Message-Id: <m132Dbb-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Differences between 8xx and 7xx MontaVista root file systems
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 14 Jun 2000 09:53:19 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Differences in operation between
	/opt/hardhat/devkit/ppc/8xx/target and
	/opt/hardhat/devkit/ppc/7xx/target from the MontaVista CDK

	Hardware:

	    EST SBC8260
	    MPC8260 Rev A.1 CPU/CPM/BUS: 200/133/66 Mhz

	MontaVista CDK packages being used:

hhl-rpmconfig-0.7-1

hhl-ppc_7xx-ash-0.2-1
hhl-ppc_7xx-bash-2.03-5
hhl-ppc_7xx-binutils-2.9.5.0.22-7
hhl-ppc_7xx-filesystem-2.0-4
hhl-ppc_7xx-fileutils-4.0-2
hhl-ppc_7xx-ftp-0.15-3
hhl-ppc_7xx-ftpd-0.11-3
hhl-ppc_7xx-gcc-2.95.2-10
hhl-ppc_7xx-gdb-4.17.0.11-2
hhl-ppc_7xx-gdb-client-4.17.0.11-2
hhl-ppc_7xx-gdb-server-4.17.0.11-2
hhl-ppc_7xx-glibc-2.1.2-10
hhl-ppc_7xx-gpm-1.17.9-1
hhl-ppc_7xx-gzip-1.2.4-2
hhl-ppc_7xx-inetd-0.10-6
hhl-ppc_7xx-ldconfig-1.9.5-2
hhl-ppc_7xx-libtermcap-2.0.8-3
hhl-ppc_7xx-microwindows-0.88pre7-1
hhl-ppc_7xx-modutils-2.1.121-2
hhl-ppc_7xx-net-tools-1.53-2
hhl-ppc_7xx-ping-0.10-6
hhl-ppc_7xx-popt-1.4-1
hhl-ppc_7xx-procps-2.0.4-2
hhl-ppc_7xx-psmisc-18-2
hhl-ppc_7xx-pump-0.7.2-1
hhl-ppc_7xx-sash-3.4-3
hhl-ppc_7xx-sh-utils-2.0-4
hhl-ppc_7xx-strace-3.99.1-2
hhl-ppc_7xx-sysvinit-2.77-6
hhl-ppc_7xx-tar-1.13.11-2
hhl-ppc_7xx-telnet-4.4.2-3
hhl-ppc_7xx-telnetd-0.10-3
hhl-ppc_7xx-termcap-9.12.6-2
hhl-ppc_7xx-textutils-2.0-2
hhl-ppc_7xx-util-linux-2.9w-4
hhl-ppc_7xx-zlib-1.1.3-2
hhl-ppc_7xx-zsrec-1.0-3

hhl-ppc_8xx-ash-0.2-1
hhl-ppc_8xx-bash-2.03-5
hhl-ppc_8xx-binutils-2.9.5.0.22-7
hhl-ppc_8xx-filesystem-2.0-4
hhl-ppc_8xx-fileutils-4.0-2
hhl-ppc_8xx-ftp-0.15-3
hhl-ppc_8xx-ftpd-0.11-3
hhl-ppc_8xx-gcc-2.95.2-10
hhl-ppc_8xx-gdb-4.17.0.11-2
hhl-ppc_8xx-gdb-client-4.17.0.11-2
hhl-ppc_8xx-gdb-server-4.17.0.11-2
hhl-ppc_8xx-glibc-2.1.2-10
hhl-ppc_8xx-gpm-1.17.9-1
hhl-ppc_8xx-gzip-1.2.4-2
hhl-ppc_8xx-inetd-0.10-6
hhl-ppc_8xx-ldconfig-1.9.5-2
hhl-ppc_8xx-libtermcap-2.0.8-3
hhl-ppc_8xx-microwindows-0.88pre7-1
hhl-ppc_8xx-modutils-2.1.121-2
hhl-ppc_8xx-net-tools-1.53-2
hhl-ppc_8xx-ping-0.10-6
hhl-ppc_8xx-popt-1.4-1
hhl-ppc_8xx-procps-2.0.4-2
hhl-ppc_8xx-psmisc-18-2
hhl-ppc_8xx-pump-0.7.2-1
hhl-ppc_8xx-sash-3.4-3
hhl-ppc_8xx-sh-utils-2.0-4
hhl-ppc_8xx-strace-3.99.1-2
hhl-ppc_8xx-sysvinit-2.77-6
hhl-ppc_8xx-tar-1.13.11-2
hhl-ppc_8xx-telnet-4.4.2-3
hhl-ppc_8xx-telnetd-0.10-3
hhl-ppc_8xx-termcap-9.12.6-2
hhl-ppc_8xx-textutils-2.0-2
hhl-ppc_8xx-util-linux-2.9w-4
hhl-ppc_8xx-zlib-1.1.3-2
hhl-ppc_8xx-zsrec-1.0-3

	Environment:

	- Using the /opt/hardhat/devkit/ppc/7xx/target for the
	  NFS mounted root filesystem
	- Linux: 2.4.0-test1-ac10

	Warnings:

	- (init) used obsolete /dev/cua - update software to use /dev/ttyS0
	- (swapper) used obsolete /dev/cua - update software to use /dev/ttyS0

	Problems:

	- "mount -o rsize=8192,wsize=8192,rw,remount /" complains about
	  "directory to mount not in host:dir format".  If I use the 8xx
	  root, then it works as expected.

	- bash does NOT provide job control.  If I use the 8xx root, then
	  bash runs with job control.

Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test1-ac10 (diekema@dell) (gcc version 2.95.2 19991024 (release)) #43 Tue Jun 13 10:08:58 EDT 2000
Boot arguments: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=126.28.1.117:/target nfsaddrs=126.1.4.5:126.28.1.117
Calibrating delay loop... 131.89 BogoMIPS
Memory: 14716k available (872k kernel code, 408k data, 48k init) [c0000000,c1000000]
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
kmem_create: Poisoning requested, but con given - bdev_cache
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
kmem_create: Poisoning requested, but con given - inode_cache
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
kmem_create: Poisoning requested, but con given - skbuff_head_cache
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Starting kswapd v1.6
CPM UART driver version 0.01
ttyS00 at 0x0000 is a SMC
ttyS01 at 0x0040 is a SMC
ttyS02 at 0x8100 is a SCC
ttyS03 at 0x8200 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
eth0: SCC ENET Version 0.1, 00:a0:1e:01:04:05
IP-Config: Guessing netmask 255.0.0.0
kmem_create: Forcing size word alignment - nfs_fh
Looking up port of RPC 100003/2 on 126.28.1.117
Looking up port of RPC 100005/2 on 126.28.1.117
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k iniü
tty_io.c: process 1 (swapper) used obsolete /dev/cua - update software to use /dev/ttyS0
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use /dev/ttý0
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use /dev/ttyS0
INIT:
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use /dev/ttyS0
version 2.77 boÿing
tty_io.c: process 1 (init) used obsolete /dev/cua - update software to use /dev/ttyS0
+ /sbin/ifconfig lo 127.0.0.1
+
+ mount /proc
+ ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:A0:1E:01:04:05
          inet addr:126.1.4.5  Bcast:126.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1094 errors:0 dropped:0 overruns:0 frame:0
          TX packets:448 errors:0 dropped:0 overruns:0 carrier:0
          collisions:3 txqueuelen:100
          Base address:0x8000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3904  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

+ mount -a
+ mount -o rsize=8192,wsize=8192,rw,remount /
mount: directory to mount not in host:dir format

# bash
bash: no job control in this shell

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
