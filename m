Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEBD8A@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Busybox of Hardhat preview 2.1 for sandpoint 74xx ?
Date: Mon, 5 May 2003 15:31:34 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did anyone know if busybox of hardhat preview 2.1 for sandpoint 74xx work or
not ?
I got error "Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted"
no matter
the root is mounted on NFS or ramfs.

If I use the 2M ram image (used bash instead of busybox) from DENX, it
worked fine.

Any suggestions ?

Thanks.

Bo



Starting at 0x800000...

loaded at:     00800000 008941BC
zimage at:     00805900 00890FD9
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 root=/dev/nfs dev=eth0
ip=192.168.0.100:192.1
68.0.50:192.168.0.50
nfsroot=192.168.0.50:/opt/hardhat/previewkit/ppc/74xx/targe
t
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
Total memory = 128MB; using 256kB for hash table (at c0180000)
Linux version 2.4.17_mvl21 (root@ibm-t30) (gcc version 2.95.3 20010315
(release/
MontaVista)) #187 Sat May 3 17:29:50 CDT 2003
Host bridge init okay
Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/nfs dev=eth0
ip=192.168.0.100:
192.168.0.50:192.168.0.50
nfsroot=192.168.0.50:/opt/hardhat/previewkit/ppc/74xx/
target
OpenPIC Version 1.2 (1 CPUs and 26 IRQ sources) at fdfd0000
time_init: decrementer frequency = 1.000000 MHz
Calibrating delay loop... 31.74 BogoMIPS
Memory: 127132k available (1020k kernel code, 396k data, 76k init, 0k
highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xfdfce000 (irq = 16) is a TI16750
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
tulip0: Old style EEPROM with no media selection information.
eth0: BPP Digital DS21143 Tulip rev 65 at 0xbfff80, EEPROM not present,
00:4C:69
:6E:75:79, IRQ 20.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.0.100, mask=255.255.255.0, gw=192.168.0.50,
     host=192.168.0.100, domain=, nis-domain=(none),
     bootserver=192.168.0.50, rootserver=192.168.0.50, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.0.50
Looking up port of RPC 100005/1 on 192.168.0.50
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init
done open console...
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted
Bad trap at PC: 300162fc, SR: f032, vector=f00    Not tainted


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
