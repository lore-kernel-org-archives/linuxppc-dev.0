Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Mike O'Brien" <mobrien@airfiber.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Hanging in Init
Date: Wed, 1 Aug 2001 11:01:59 -0700
Message-ID: <000101c11ab4$0fc48f60$6865a8c0@airfiber.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been trying to get a custom PPC860 board up using MonteVista's Hard
Hat
2.0 distribution using a vxWorks bootrom.  I have made alot of progress in
the last
few days but have got stuck at the point here init is executed.  The IMMR is
set
to 0x02200000.  I ran across some old posts on the list referring to this
being set
too low for linux.  Could this be the problem?  If not does anyone have any
suggestions on what could be wrong?  Attached is the boot up output from the
console.

Thanks,
Mike O'Brien

Attaching network interface cpm0... done.
Attaching network interface lo0... done.
Loading... 504934
WARNING: CRC mismatch (calculated 0x1a946201 expected 0x017c1f7c)
Starting at 0x1180000...

loaded at:     01180000 0118A1DC
relocated to:  00180000 0018A1DC
board data at: 001801C0 001801DC
relocated to:  00200100 0020011C
zimage at:     01187000 011F828A
avail ram:     00201000 02000000

Linux/PPC load: root=/dev/nfs rw init=/bin/sh
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.2_hhl20 (root@palm) (gcc version 2.95.3 20010315
(release/Mon1
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw init=/bin/sh
Decrementer Frequency = 123750000/60
Warning: real time clock seems stuck!
Calibrating delay loop... 32.87 BogoMIPS
Memory: 30940k available (864k kernel code, 320k data, 48k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Calling smp_init()...
Calling kernel_thread()...
Calling unlock_kernel()...
Entered init()...
Calling do_basic_setup()...
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
i2c-core.o: i2c core module
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 20488kB/6829kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 08:00:3e:26:15:59
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.101.239, my address is
192.168.101.98
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.101.239
Looking up port of RPC 100005/2 on 192.168.101.239
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init 4k openfirmware
Unlock kernel...
Open console...
Call /sbin/init...

[hang]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
