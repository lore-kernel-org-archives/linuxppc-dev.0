Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <004101c3eb87$d2cdf090$5e1312ac@yang>
From: "yang" <wchyang_hn@sina.com>
To: <linuxppc-embedded@lists.linuxppc.org>, <wchyang_hn@sina.com>
Subject: Problem  of  linux's  kernel  booting
Date: Thu, 5 Feb 2004 09:31:42 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
    I encounter a problem when booting linux 2.2.4 kernel on FADS860T board by ppcboot-2.0.
    After mounting NFS filesystem on my host, the follow message was printed in console:

        ## Booting image at ffe80000 ...
           Image Name:   Linux-2.4.4
           Image Type:   PowerPC Linux Kernel Image (gzip compressed)
           Data Size:    457580 Bytes = 446.9 kB
           Load Address: 00000000
           Entry Point:  00000000
           Verifying Checksum ... OK
           Uncompressing Kernel Image ... OK
        Linux version 2.4.4 (yang@vlinux) (gcc version 2.95.3 20010315 (release/MontaVis
        ta)) #12 Tue Feb 3 19:37:20 CST 2004
        On node 0 totalpages: 8192
        zone(0): 8192 pages.
        zone(1): 0 pages.
        zone(2): 0 pages.
        Kernel command line: root=/dev/nfs rw nfsroot=172.18.19.254:/opt/nfsfilesystem/
        ip=172.18.19.253:172.18.19.254:172.18.19.1:255.255.255.0:vmlinux::off
        Decrementer Frequency: 3125000
        Warning: real time clock seems stuck!
        Calibrating delay loop... 49.86 BogoMIPS
        Memory: 30868k available (920k kernel code, 336k data, 44k init, 0k highmem)
        Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
        Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
        Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
        Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
        POSIX conformance testing by UNIFIX
        Linux NET4.0 for Linux 2.4
        Based upon Swansea University Computer Society NET3.039
        Starting kswapd v1.8
        CPM UART driver version 0.03
        ttyS0 on SMC1 at 0x0280, BRG1
        ttyS1 on SMC2 at 0x0380, BRG2
        pty: 256 Unix98 ptys configured
        block: queued sectors max/low 20440kB/6813kB, 64 slots per queue
        eth0: CPM ENET Version 0.2 on SCC1, 44:00:00:00:00:00
        CFI: Found no TQM8xxL Bank 0 device at location zero
        CFI: Found no TQM8xxL Bank 1 device at location zero
        CFI: Found no TQM8xxL Bank 2 device at location zero
        CFI: Found no TQM8xxL Bank 3 device at location zero
        TQM8xxL: No support flash chips found!
        NET4: Linux TCP/IP 1.0 for NET4.0
        IP Protocols: ICMP, UDP, TCP, IGMP
        IP: routing cache hash table of 512 buckets, 4Kbytes
        TCP: Hash tables configured (established 2048 bind 2048)
        NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
        Looking up port of RPC 100003/2 on 172.18.19.254
        Looking up port of RPC 100005/2 on 172.18.19.254
        VFS: Mounted root (nfs filesystem).
        Freeing unused kernel memory: 44k init
        Kernel panic: No init found.  Try passing init= option to kernel.
        Rebooting in 180 seconds..

    Would you like to tell me how to make NFS filesystem on my host, especialy how to config the init options of kenel? Thank you very much!
    Best regards,
                                     yang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
