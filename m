Message-ID: <1054052583.3ed390e734f93@webmail.colorado.edu>
Date: Tue, 27 May 2003 10:23:03 -0600
From: Phill Treddenick <Phillip.Treddenick@colorado.edu>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem booting kernel on EP405
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I am trying to run Monta Vista Linux PE 2.1 on an EP405 with Solaris 2.7 as
the host.  When I boot the kernel on the EP405 though, I get a couple of boot
error messages.  The kernel continues booting however and gets to a login
prompt, if I try to login though it fails.  Can anyone provide me with
information about the errors I'm getting.  Specifically, the "modprobe:
modprobe: Can't locate module char-major-4" and the "mknod: `/dev/ptmx':
Operation not permitted" errors.  I would like to know where I would find the
char-major-4 module or why the kernel can't find it.  Here are the boot messages
and a failed login attempt. Thanks guys.


>g
[Go 00000000]

loaded at:     00000000 0008E1D0
relocated to:  00400000 0048E1D0
board data at: 0048B128 0048B140
relocated to:  00405694 004056AC
zimage at:     00405D30 0048A528
avail ram:     0048F000 04000000

Linux/PPC load: console=ttyS0,9600 root=/dev/nfs
nfsroot=128.138.189.51:/opt/hardhat/devkit/ppc/405/target
ip=128.138.189.65:128.138.189.
51::255.255.255.0:sme.colorado.edu::
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.17_mvl21-walnut (root@goddard) (gcc version 2.95.3 20010315
(release/MontaVista)) #10 Thu May 15 12:51:39 MDT 2003
CPMFR:0x94400000
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 root=/dev/nfs
nfsroot=128.138.189.51:/opt/hardhat/devkit/ppc/405/target
ip=128.138.189.65:128.138
.189.51::255.255.255.0:sme.colorado.edu::
Calibrating delay loop... 199.88 BogoMIPS
Memory: 62984k available (976k kernel code, 396k data, 72k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
i2c-core.o: i2c core module version 2.6.2 (20011118)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enabled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x0, type LXT971A (0x001378e1)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Reset ethernet interfaces
eth0: PPC405 EMAC: link up, 100 Mbps Full Duplex, auto-negotiation complete.
eth0: PPC405 EMAC: MAC 00:10:ec:00:2f:62.
eth0: PPC405 Enet open completed
IP-Config: Complete:
      device=eth0, addr=128.138.189.65, mask=255.255.255.0, gw=255.255.255.255,
     host=sme, domain=, nis-domain=colorado.edu,
     bootserver=128.138.189.51, rootserver=128.138.189.51, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 128.138.189.51
Looking up port of RPC 100005/1 on 128.138.189.51
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 72k init
modprobe: modprobe: Can't locate module char-major-4
INIT: version 2.78 booting
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.22 (22-Jun-2001)
Calculating module dependencies... done.
Loading modules:
mknod: `/dev/ptmx': Operation not permitted
Mounting local filesystems...
nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Configuring network interfaces: done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run/etc/init.d/rcS:INIT: Entering runlevel: 2
Starting system log daemon: syslogd klogd.
Starting internet superserver: inetd.

MontaVista Linux 2.1, Professional Edition

sme login: root
PAM_unix[82]: (login) session opened for user root by (uid=0)


Welcome to MontaVista Linux 2.1, Professional Edition

login[82]: unable to change tty `/dev/console' for user `root'

Unable to change tty /dev/console: Illegal seek

MontaVista Linux 2.1, Professional Edition

sme login:


Phill Treddenick
treddeni@colorado.edu
303 818-7694

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
