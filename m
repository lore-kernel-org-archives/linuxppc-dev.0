Return-Path: <yulq@jiaxun.com>
Received: from mail.jiaxun.com (unknown [203.86.85.181])
	by ozlabs.org (Postfix) with ESMTP id 19FFD679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 19:55:28 +1000 (EST)
Received: from OAserver.jiaxun.com ([192.168.1.15])
	by jiaxun.com (mail.jiaxun.com) (MDaemon PRO v9.0.1)
	with ESMTP id md50000015695.msg
	for <linuxppc-embedded@ozlabs.org>; Tue, 01 Aug 2006 17:40:09 +0800
Subject: Portting Linux to MPC8247
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFD5A94E76.35C9DC91-ON482571BD.0035CDCB-482571BD.00361363@jiaxun.com>
From: yulq@jiaxun.com
Date: Tue, 1 Aug 2006 17:53:56 +0800
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

I'm portting Linux to MPC8247 using ELDK-3.0 Kit and U-boot-1.1.4.
The boot and kernel work well. But the console can't print anything.
In /etc/inittab, I append line: s0:2345:respawn:/sbin/mingetty ttyS0 9600
linux.

... ...

Kernel command line: console=ttyS0,9600n8 root=/dev/nfs rw
nfsroot=192.168.2.147
:/home/yulq/eldk/ppc_82xx
ip=192.168.2.130:192.168.2.147:192.168.2.147:255.255.2
55.0:yulq:eth0:off
Warning: real time clock seems stuck!
Calibrating delay loop... 131.89 BogoMIPS
Memory: 31040k available (956k kernel code, 320k data, 56k init, 0k
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
Looking up port of RPC 100003/2 on 192.168.2.147
Looking up port of RPC 100005/1 on 192.168.2.147
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init
Open an initial console successful.


Where is the problem ? Thanks.
