Message-ID: <000701c212b6$20237e20$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Ramdisk can not be loaded!
Date: Thu, 13 Jun 2002 16:41:32 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,
        I want to run linux-2.2.13 on my FADS board! when I bootm linux image without ramdisk,
it has the folling message first,but when boot linux with ramdisk ,it has the another message
like following,it seems program has exception in task SWAPPER.has anyone meet this problem,Can
you give some good advise? thank you in advance!

Following is Message without ramdisk:

=>tftpboot 500000 linux-2.2.13.ppcboot
ARP broadcast 1

Retry count exceeded; starting again
ARP broadcast 1
TFTP from server 192.168.1.105; our IP address is 192.168.1.99
Filename 'linux-2.2.13.ppcboot'.
Load address: 0x500000
Loading: ######################################
done
Bytes transferred = 193622 (2f456 hex)
=>bootm 500000
## Booting image at 00500000 ...
   Image Name:   2.2.13
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    193558 Bytes = 189 kB = 0 MB
   Load Address: 00000000
   Entry Point:  0000000c
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.2.13 (root@gaof.guoguang.com.cn) (gcc version 2.95.2 19991024 (r
elease)) #3 Thu Jun 13 10:37:58 CST 2002
Boot arguments: root=/dev/ram rw
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 7552k available (356k kernel code, 264k data, 20k init) [c0000000,c08000
00]
Dentry hash table entries: 1024 (order 1, 8k)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
RAM disk driver initialized:  16 RAM disks of 4096K size
initrd_start 0,mount_initrd 0 ,will be initrd_load
VFS: Cannot open root device c0:0b
Kernel panic: VFS: Unable to mount root fs on c0:0b
Rebooting in 180 seconds..

following is Message with ramdisk:


## Booting image at 02880000 ...
   Image Name:   2.2.13
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    193558 Bytes = 189 kB = 0 MB
   Load Address: 00000000
   Entry Point:  0000000c
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 02900000 ...
   Image Name:   ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    428 Bytes = 0 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0075b000, end 0075b1ac ... OK
Linux version 2.2.13 (root@gaof.guoguang.com.cn) (gcc version 2.95.2 19991024 (r
elease)) #3 Thu Jun 13 10:37:58 CST 2002
Boot arguments: root=/dev/ram rw
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 7548k available (356k kernel code, 264k data, 20k init) [c0000000,c08000
00]
Dentry hash table entries: 1024 (order 1, 8k)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
NIP: C000CD38 XER: A000007F LR: C0052934 REGS: c00649f8 TRAP: 0300 DAR: cccccc33

MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0062cb8[0] 'swapper' mm->pgd c0061000 Last syscall: 0
last math 00000000
GPR00: C0052934 C0064AA8 C0062CB8 CCCCCC33 00000001 0000000D 0000001A FFFFFFFF
GPR08: FFFFFFFF 00000003 00000003 00000000 00000040 00000008 007D9010 0075B360
GPR16: 0000000C 00000001 0075B350 FFFFFFFF 007D20F4 00000000 0075BEF8 C0080000
GPR24: 00000000 00000004 C006AB94 00000004 00000001 C0071098 333333CC C0064AA8
Call backtrace:
00000000 C0052934 C0052B08 C006EF58 C006C720 C000221C
Kernel panic: kernel access of bad area pc c000cd38 lr c0052934 address CCCCCC33
 tsk swapper/0
In swapper task - not syncing
Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
