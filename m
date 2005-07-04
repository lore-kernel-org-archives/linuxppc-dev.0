Return-Path: <bvinodsmail@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.205])
	by ozlabs.org (Postfix) with ESMTP id 7979F67C22
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jul 2005 18:19:43 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i6so657018wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 04 Jul 2005 01:19:41 -0700 (PDT)
Message-ID: <198df04d05070401194827abfe@mail.gmail.com>
Date: Mon, 4 Jul 2005 13:49:41 +0530
From: vinod b <bvinodsmail@gmail.com>
To: linuxppc-embedded@ozlabs.org, ebs@ebshome.net, rcblach@raleigh.ibm.com,
	samlinuxppc@yahoo.com.cn
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: linux ppc 405 boot problem using nfs.
Reply-To: vinod b <bvinodsmail@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Iam trying to boot linux on Powerpc405GP board(walnut).
When i do it using ram disk concept.I do not have any problem.
But when i mount file system from the remote system i have problem.
can any one help me..........
I am sending the minicom out put of both using ram disk concept anf
nfs mounting.

Can any body tell if there is any problem in the walnut board in
sending packets...................

This output is in the case of using nfs to mount the file system .
=20
Welcome to minicom 2.1

OPTIONS: History Buffer, F-key Macros, Search History Buffer, I18n
Compiled on Jun 15 2003, 14:35:38.

Press CTRL-A Z for help on special keys



405GP 1.13 ROM Monitor (4/7/00)

 --------------------- System Info ----------------------
 Processor         =3D 405GP,   PVR: 40110082
 Processor speed   =3D 200 MHz
 PLB speed         =3D 100 MHz
 OPB speed         =3D 50 MHz
 Ext Bus speed     =3D 50 MHz
 PCI Bus speed     =3D 33 MHz (Sync)
 Amount of SDRAM   =3D 32 MBytes
 Internal PCI arbiter enabled
 --------------------------------------------------------

 --- Device Configuration ---
 Power-On Test Devices:
   000  Disabled  System Memory [RAM]
   001  Disabled  Ethernet      [ENET]
   004  Disabled  Serial Port 2 [S2]
 ----------------------------
 Boot Sources:
   001  Enabled   Ethernet      [ENET]
                  local=3D192.0.1.253  remote=3D192.0.1.53  hwaddr=3D0004ac=
e30f38
   004  Disabled  Serial Port 2 [S2]
                  local=3D192.0.1.253  remote=3D192.0.1.50  hwaddr=3Dffffff=
ffffff
   005  Disabled  Serial Port 1 [S1]
                  Baud =3D 9600
 ----------------------------
 Debugger: Disabled
 ----------------------------
  1 - Enable/disable tests
  2 - Enable/disable boot devices
  3 - Change IP addresses
  4 - Ping test
  5 - Toggle ROM monitor debugger
  6 - Toggle automatic menu
  7 - Display configuration
  8 - Save changes to configuration
  9 - Set baud rate for s1 boot
  A - Enable/disable I cache (Enabled )
  B - Enable/disable D cache (Enabled )
  0 - Exit menu and continue
->0
ENET Speed is 100 Mbs...
FULL duplex connection
Booting from [ENET] Ethernet     ...
Sending bootp request ...


Loading file "/tftpboot/zImage.treeboot" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x500000 ...

loaded at:     00500000 0059E1F8
relocated to:  00400000 0049E1F8
board data at: 0049B128 0049B168
relocated to:  004054AC 004054EC
zimage at:     004059E8 0049ABCB
avail ram:     0049F000 02000000

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/nfs rw ip=3Don init=3D/bin=
/bash
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.18_mvl30-405ep_eval (root@Aum-Sai) (gcc version
3.2.1 20020930 (Mon5
IBM Walnut (IBM405GP) Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=3DttyS0,9600 root=3D/dev/nfs rw ip=3Don init=
=3D/bin/bash
Calibrating delay loop... 199.47 BogoMIPS
Memory: 30788k available (1024k kernel code, 344k data, 72k init, 0k highme=
m)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.2.1 init complete
Starting kswapd
Disabling the Out Of Memory Killer
i2c-core.o: i2c core module version 2.6.2 (20011118)
initialize_kbd: Keyboard reset failed, no ACK
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xef600300 (irq =3D 0) is a 16550A
ttyS01 at 0xef600400 (irq =3D 1) is a 16550A
block: 64 slots per queue, batch=3D16
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x1, type DP83843 (0x20005c10)
Reset ethernet interfaces
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
opening eth0 on emac 0
eth0: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:0f:38.
eth0: IBM EMAC: open completed
Sending BOOTP and RARP requests . OK
IP-Config: Got BOOTP answer from 192.0.1.53, my address is 192.0.1.253
IP-Config: Complete:
      device=3Deth0, addr=3D192.0.1.253, mask=3D255.255.255.0, gw=3D255.255=
.255.255,
     host=3D192.0.1.253, domain=3D, nis-domain=3D(none),
     bootserver=3D192.0.1.53, rootserver=3D192.0.1.53, rootpath=3D/home/wal=
nut/target
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.0.1.53
Looking up port of RPC 100005/1 on 192.0.1.53
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 72k init
nfs server: 192.0.1.53 not responding, still trying ...
nfs server: 192.0.1.53 ok
nfs server: 192.0.1.53 not responding, still trying ...
nfs server: 192.0.1.53 ok



Now the out put when file system is used as ram disk........

=20

405GP 1.13 ROM Monitor (4/7/00)

 --------------------- System Info ----------------------
 Processor         =3D 405GP,   PVR: 40110082
 Processor speed   =3D 200 MHz
 PLB speed         =3D 100 MHz
 OPB speed         =3D 50 MHz
 Ext Bus speed     =3D 50 MHz
 PCI Bus speed     =3D 33 MHz (Sync)
 Amount of SDRAM   =3D 32 MBytes
 Internal PCI arbiter enabled
 --------------------------------------------------------

 --- Device Configuration ---
 Power-On Test Devices:
   000  Disabled  System Memory [RAM]
   001  Disabled  Ethernet      [ENET]
   004  Disabled  Serial Port 2 [S2]
 ----------------------------
 Boot Sources:
   001  Enabled   Ethernet      [ENET]
                  local=3D192.0.1.253  remote=3D192.0.1.50  hwaddr=3D0004ac=
e30f38
   004  Disabled  Serial Port 2 [S2]
                  local=3D192.0.1.253  remote=3D192.0.1.50  hwaddr=3Dffffff=
ffffff
   005  Disabled  Serial Port 1 [S1]
                  Baud =3D 9600
 ----------------------------
 Debugger: Disabled
 ----------------------------
  1 - Enable/disable tests
  2 - Enable/disable boot devices
  3 - Change IP addresses
  4 - Ping test
  5 - Toggle ROM monitor debugger
  6 - Toggle automatic menu
  7 - Display configuration
  8 - Save changes to configuration
  9 - Set baud rate for s1 boot
  A - Enable/disable I cache (Enabled )
  B - Enable/disable D cache (Enabled )
  0 - Exit menu and continue
->0
ENET Speed is 100 Mbs...
FULL duplex connection
Booting from [ENET] Ethernet     ...
Sending bootp request ...


Loading file "/tftpboot/zImage.treeboot" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x500000 ...

loaded at:     00500000 007E51F8
relocated to:  00400000 006E51F8
board data at: 006E2128 006E2168
relocated to:  004054A0 004054E0
zimage at:     004059DC 0049AA0C
initrd at:     0049B000 006E1B21
avail ram:     006E6000 02000000

Linux/PPC load: console=3DttyS0,9600 root=3D/dev/ram init=3D/bin/bash
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.18_mvl30-405ep_eval (root@Aum-Sai) (gcc version
3.2.1 20020930 (MontaVista)) #1 Fri Jun 24 11:19:36 IST 5
IBM Walnut (IBM405GP) Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=3DttyS0,9600 root=3D/dev/ram init=3D/bin/bash
Calibrating delay loop... 199.47 BogoMIPS
Memory: 28456k available (1024k kernel code, 344k data, 72k init, 0k highme=
m)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.2.1 init complete
Starting kswapd
Disabling the Out Of Memory Killer
i2c-core.o: i2c core module version 2.6.2 (20011118)
initialize_kbd: Keyboard reset failed, no ACK
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xef600300 (irq =3D 0) is a 16550A
ttyS01 at 0xef600400 (irq =3D 1) is a 16550A
block: 64 slots per queue, batch=3D16
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x1, type DP83843 (0x20005c10)
Reset ethernet interfaces
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
opening eth0 on emac 0
eth0: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:0f:38.
eth0: IBM EMAC: open completed
Sending BOOTP and RARP requests . OK
IP-Config: Got BOOTP answer from 192.0.1.53, my address is 192.0.1.253
IP-Config: Complete:
      device=3Deth0, addr=3D192.0.1.253, mask=3D255.255.255.0, gw=3D255.255=
.255.255,
     host=3D192.0.1.253, domain=3D, nis-domain=3D(none),
     bootserver=3D192.0.1.53, rootserver=3D192.0.1.53, rootpath=3D/home/wal=
nut/target
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 2330k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k init
init-2.04# ls



=20
--=20
vinod
S.S.S.I.H.L
