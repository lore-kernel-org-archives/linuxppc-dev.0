Message-ID: <000c01be912b$57c804a0$6ef102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: LinuxPPC on FADS, Help Please!
Date: Wed, 28 Apr 1999 11:54:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello everyone,
  I have built a kernel for MPC860 FADS ,
which the code based the embedded-2_2p7.tar.gz.
And I have made a root disk as initrd.
After the system boot up,
I could not login in using root account,
it always complains "user unknown".

Ask: Except for /etc/passwd,
Which files need I provide?
I do not know how the system authorize to the users
when I login.

Any suggestion is appreciated!
Thanks in advanced!

Best Regards,
Zhu Shuangjun

==================================================
loaded at:     00400000 00411090
board data at: 000FEB08 000FEB18
relocated to:  00407124 00407134
zimage at:     0041649F 0046A5ED
initrd at:     0046A5ED 005A1EF7
relocated to:  00EC8000 00FFF90A
avail ram:     0046B000 00EC8000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.0-pre7 (sjzhu@linux.mcel.mot.com) (gcc version
2.7.2.1-ppclinu
x) #226 Wed Apr 28 19:31:10 CST 1999
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 90000000/60
Calibrating delay loop... 23.76 BogoMIPS
Memory: 13960k available (676k kernel code, 500k data, 0k init)
[c0000000,c10000
00]
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
RAM disk driver initialized:  16 RAM disks of 4096K size
CPM ENET Version 0.1, 08:00:3e:58:41:21
RAMDISK: Compressed image found at block 0
crc errorEXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
INIT: version 2.64 bootingry: 0k init
We will not activate swap partitions
hostname: LinuxFADS.mcel.mot.com
Remounting root filesystem in read-write mode.
Mounting local filesystems.
Initializing random number generator...
INIT: Entering runlevel 3
Delaying eth0 initialization.
Mounting remote filesystems.


Linux for PowerPC. Brought to you by The LinuxPPC Project.
Based on Red Hat Linux release 3.0.3
Kernel 2.2.0-pre7 on a PowerPC 860

LinuxFADS login: root
Password:
A<33>Feb 26 01:29:19 PAM_pwdb[88]: check pass; user unknown
?37>Feb 26 01:29:19 PAM_pwdb[88]: FAILED LOGIN 1 FROM (null) FOR root, User
not
 known to the underlying authentication module
Login incorrect

login: Login timed out after 60 seconds


Linux for PowerPC. Brought to you by The LinuxPPC Project.
Based on Red Hat Linux release 3.0.3
Kernel 2.2.0-pre7 on a PowerPC 860

LinuxFADS login:
==================================================


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
