Message-ID: <20000712102145.5376.qmail@web2102.mail.yahoo.com>
Date: Wed, 12 Jul 2000 03:21:45 -0700 (PDT)
From: Wentao Xu <xuwentao@yahoo.com>
Subject: Why eth0 does not work
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, everyone,
I am porting the linux code from mvista to IBM redwood
board. Now it seems like the eth0 is not registered
because the NFS uses loopback device. Who can give me
an idea? Thanks in advance.

the output is
-----------------------------------------------------
Linux version 2.3.39 (xwt@stb_dev) (gcc version 2.95.2
19991024 (release)) #393
Wed Jul 12 17:02:16 CST 2000
walnut_setup_arch()
----------  progress:  0x3eab arch: exit
On node 0 totalpages: 00001800
zone(0): 6144 pages.
zone(1): 0 pages.
zone(2): 0 pages.
ERROR: ppc4xx_pic_init() detected wrong PVR_VER

-----  in walnut_calibrate_decr()

  bip:

    bi_s_version      1.3
    bi_r_version      1.13
    bi_memsize        0x1800000
    bi_enetaddr       123456-7890ab
    bi_pci_enetaddr   000002-f34f60
    bi_procfreq       0x2f34f60
    bi_plb_busfreq    0x4e800021
    bi_pci_busfreq    0x0

Calibrating delay loop... 49.25 BogoMIPS
Memory: 22704k available (800k kernel code, 580k data,
48k init) [c0000000,c1800
000]
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 8192 (order: 3, 32768
bytes)
POSIX conformance testing by UNIFIX
----------  progress:  0xffff
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society
NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind
4096)
Starting kswapd v1.6
tty_init() -- calling rs_init()
Serial driver version 4.91 (1999-11-17) with no serial
options enabled
ttyS00 at 0x0000 (irq = 20) is a 16550A
tty_init() -- returned from rs_init()
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
eth0: National DP83902AV at 12:34:56:78:90:ab, found
at 0xf1400000, using IRQ 26
.
Looking up port of RPC 100003/2 on 7.1.1.21
Device lo is down.
Device lo is down.
Device lo is down.
Device lo is down.
portmap: server 7.1.1.21 not responding, timed out
Root-NFS: Unable to get nfsd port number from server,
using default
Looking up port of RPC 100005/1 on 7.1.1.21
Device lo is down.
Device lo is down.
Device lo is down.
Device lo is down.
portmap: server 7.1.1.21 not responding, timed out
Root-NFS: Unable to get mountd port number from
server, using default
Device lo is down.
Device lo is down.
Device lo is down.
Device lo is down.
mount: server 7.1.1.21 not responding, timed out
Root-NFS: Server returned error -5 while mounting
/opt/hardhat/devkit/ppc/8xx/ta
rget_ftest4
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device 02:00
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..
-------------------------------------------------------

Wentao


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
