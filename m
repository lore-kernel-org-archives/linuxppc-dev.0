Return-Path: <yulq@jiaxun.com>
Received: from mail.jiaxun.com (unknown [203.86.85.181])
	by ozlabs.org (Postfix) with ESMTP id A704367B52
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 11:33:59 +1000 (EST)
Received: from OAserver.jiaxun.com ([192.168.1.15])
	by jiaxun.com (mail.jiaxun.com) (MDaemon PRO v9.0.1)
	with ESMTP id md50000015613.msg
	for <linuxppc-embedded@ozlabs.org>; Tue, 01 Aug 2006 09:10:02 +0800
Subject: Portting Linux to MPC8247
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF445DE9B2.5898E3C7-ON482571BD.0006EE5B-482571BD.00075E7F@jiaxun.com>
From: yulq@jiaxun.com
Date: Tue, 1 Aug 2006 09:23:47 +0800
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am portting Linux(ver. 2.4.24) to MPC8247. I use U-boot and ELDK Kit.
The boot and kernel works well, but when the init process to execute
/sbin/init the board restarts. The message is shown following:

... ...

Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.24-pre2 (yulq@MDS-Server) (gcc version 3.2.2 20030217
(Yellow
Dog Linux 3.0 3.2.2-2a_1)) #99 Mon Jul 31 17:51:08 CST 2006
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600n8 root=/dev/ram
ip=192.168.2.130:192.168
.2.147:192.168.2.147:255.255.255.0:yulq::off
Warning: real time clock seems stuck!
Calibrating delay loop... 131.89 BogoMIPS
Memory: 27088k available (988k kernel code, 324k data, 52k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS0 on SMC1 at 0x0000, BRG7
ttyS1 on SCC1 at 0x8000, BRG1
ttyS2 on SCC2 at 0x8100, BRG2
pty: 256 Unix98 ptys configured
eth0: FCC1 ENET Version 0.4, 08:00:3E:2D:9D:5B
eth0: Phy @ 0x1, type LXT971 (0x001378e2)
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
IP-Config: Complete:
      device=eth0, addr=192.168.2.130, mask=255.255.255.0,
gw=192.168.2.147,
     host=yulq, domain=, nis-domain=(none),
     bootserver=192.168.2.147, rootserver=192.168.2.147, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 3919k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 52k init
Open an initial console successful

Board restarts !

What is the problem ?
