Date: Thu, 29 May 2003 19:30:05 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Linux boots on MPC8540
From: Kumar Gala <kumar.gala@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <DBEEE757-9235-11D7-9796-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For those with any interest in embedded parts from Motorola, here is a
boot log from
early PQIII silicon we have running in the lab.

  Kumar Gala
  Andy Fleming
  Xianghua Xiao

--------------------------------------
mpc85xx_init(): exit
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
Linux version 2.4.21-pre3 (galak@blarg.somerset.sps.mot.com) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a)) #308 Tue May 27
17:59:16 CDT 2003
setup_arch: enter
setup_arch: bootmem
mpc85xx_setup_arch
arch: exit
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=10.82.0.102:/nfsroot/galak/ppc_85xx
ip=10.82.0.103:10.82.0.102:10.82.1.254:255.255.254.0:rhuath::off
console=ttyS0,115200
openpic: enter
OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fdf40000
openpic: timer
openpic: external
openpic: spurious
openpic: exit
time_init: decrementer frequency = XX.XXXXXX MHz
Calibrating delay loop... XXXXXX BogoMIPS
Memory: 257636k available (1036k kernel code, 332k data, 56k init, 0k
highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfdf04500 (irq = 26) is a 16550A
ttyS01 at 0xfdf04600 (irq = 0) is a 16550A
eth0: Three Speed Ethernet Controller Version 0.00001,
00:0a:28:0a:0b:0e:
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IP-Config: Complete:
       device=eth0, addr=10.82.0.103, mask=255.255.254.0, gw=10.82.1.254,
      host=rhuath, domain=, nis-domain=(none),
      bootserver=10.82.0.102, rootserver=10.82.0.102, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.82.0.102
Looking up port of RPC 100005/1 on 10.82.0.102
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init

rhuath login: root
Last login: Wed Dec 31 21:43:21 on console
bash-2.05# cat /proc/cpuinfo
cpu		: e500
revision	: 0.16 (pvr 8020 0010)
bogomips	: XXXXXX
Vendor		: Motorola SPS
Machine		: mpc8540
Memory		: 256 MB
bash-2.05#

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
