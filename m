Message-ID: <20040821125058.94889.qmail@web15605.mail.cnb.yahoo.com>
Date: Sat, 21 Aug 2004 20:50:58 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: 30MB ramdisk needs more than  64MB SDRAM?
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <FE889179-F1F1-11D8-8765-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

My ramdisk biniary is about 30MB(uncompressed).There
are 128MB SDRAM + 64MB FLASH on my board.When I
decreased 128MB SDRAM to 64MB by changing two CS to
one CS,kernel hanged when copying 30MB ramdisk to
SDRAM.I was wondering why 30MB ramdisk need more than
64MB SDRAM?Yeah,30MB ramdisk can work right with 128MB
SDRAM.

U-Boot 1.1.1 (Aug 21 2004 - 10:58:43)

CPU:   PPC823EZTnnB2 at 48 MHz: 16 kB I-Cache 8 kB
D-Cache
Board: IEMC-SHU-1
DRAM:  64 MB
FLASH: 64 MB
In:    serial
Out:   serial
Err:   serial
Net:   SCC ETHERNET
......
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind
8192)
IP-Config: Complete:
      device=eth0, addr=172.16.115.12,
mask=255.255.255.0, gw=172.16.115.254,
     host=172.16.115.12, domain=, nis-domain=(none),
     bootserver=172.16.115.6, rootserver=172.16.115.6,
rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 30720 blocks [1 disk] into ram
disk... /

[hanged]

Any ideas?

Thanks in advance!!!

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
