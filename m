Return-Path: <bvinodsmail@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.197])
	by ozlabs.org (Postfix) with ESMTP id 92C6867B31
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Jun 2005 14:49:39 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so110407wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Jun 2005 21:49:38 -0700 (PDT)
Message-ID: <198df04d0506212149550448ed@mail.gmail.com>
Date: Wed, 22 Jun 2005 10:19:37 +0530
From: vinod b <bvinodsmail@gmail.com>
To: samlinuxppc@yahoo.com.cn, linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3697_687823.1119415777992"
Subject: booting linux on powerpc 405
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

------=_Part_3697_687823.1119415777992
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

thanks for the response sir.

sir i created nodes on the dev directory using the command mknode.Even afte=
r=20
doing this i have problem.I do not know if there is any problem with nfs=20
server.But as it is seen in the output on the minicom window sigseg signal=
=20
occeurs then kernel panic happens.So how can this problem be solved.

I am sending the new output=20
Welcome to minicom 2.00.0

OPTIONS: History Buffer, F-key Macros, Search History Buffer, I18n
Compiled on Jan 25 2003, 00:15:18.

Press CTRL-A Z for help on special keys



405GP 1.13 ROM Monitor (4/7/00)

--------------------- System Info ----------------------
Processor =3D 405GP, PVR: 40110082
Processor speed =3D 200 MHz
PLB speed =3D 100 MHz
OPB speed =3D 50 MHz
Ext Bus speed =3D 50 MHz
PCI Bus speed =3D 33 MHz (Sync)
Amount of SDRAM =3D 32 MBytes
Internal PCI arbiter enabled
--------------------------------------------------------

--- Device Configuration ---
Power-On Test Devices:
000 Disabled System Memory [RAM]
001 Disabled Ethernet [ENET]
004 Disabled Serial Port 2 [S2]
----------------------------
Boot Sources:
001 Enabled Ethernet [ENET]
local=3D192.0.1.253 <http://192.0.1.253> remote=3D192.0.1.50
<http://192.0.1.50>hwaddr=3D0004ace30f38
004 Disabled Serial Port 2 [S2]
local=3D8.1.1.2 <http://8.1.1.2>
remote=3D255.255.255.255<http://255.255.255.255>hwaddr=3Dffffffffffff
005 Disabled Serial Port 1 [S1]
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
B - Enable/disable D cache (Disabled)
0 - Exit menu and continue
->0
ENET Speed is 100 Mbs...
FULL duplex connection
Booting from [ENET] Ethernet ...
Sending bootp request ...


Loading file "/tftpboot/zImage.treeboot" ...
Sending tftp boot request ...
Transfer Complete ...
Loaded successfully ...
Entry point at 0x500000 ...

loaded at: 00500000 0059E1F8
relocated to: 00400000 0049E1F8
board data at: 0049B128 0049B168
relocated to: 00405470 004054B0
zimage at: 004059AC 0049A376
avail ram: 0049F000 02000000

Linux/PPC load: root=3D/dev/nfs rw ip=3Don
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.18_mvl30-405ep_eval (root@sairam) (gcc version
3.2.1200209305IBM Walnut (IBM405GP) Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/nfs rw ip=3Don
Calibrating delay loop... 199.47 BogoMIPS
Memory: 30800k available (1024k kernel code, 332k data, 72k init, 0k=20
highmem)
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
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ=20
SERIAL_PCI edttyS00 at 0xef600300 (irq =3D 0) is a 16550A
ttyS01 at 0xef600400 (irq =3D 1) is a 16550A
block: 64 slots per queue, batch=3D16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
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
IP-Config: Got BOOTP answer from 192.0.1.50 <http://192.0.1.50>, my address=
=20
is 192.0.1.253 <http://192.0.1.253>
IP-Config: Complete:
device=3Deth0, addr=3D192.0.1.253 <http://192.0.1.253>,
mask=3D255.255.255.0<http://255.255.255.0>,
gw=3D255.255.255.255 <http://255.255.255.255>,
host=3D192.0.1.253 <http://192.0.1.253>, domain=3D, nis-domain=3D(none),
bootserver=3D192.0.1.50 <http://192.0.1.50>,
rootserver=3D192.0.1.50<http://192.0.1.50>,
rootpath=3D/home/vinod/target
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.0.1.50 <http://192.0.1.50>
Looking up port of RPC 100005/1 on 192.0.1.50 <http://192.0.1.50>
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 72k init
Oops: kernel access of bad area, sig: 11
NIP: C00EB22C XER: 00000000 LR: C00E900C SP: C0121CB0 REGS: c0121bf0 TRAP:=
=20
0800dMSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DEAR: 00000000, ESR: 00000000
TASK =3D c011fff0[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
PLB0: bear=3D 0x10000000 acr=3D 0x00000000 besr=3D 0x00000000
PLB0 to OPB: bear=3D 0x00001024 besr0=3D 0x00000000 besr1=3D 0x00000000

GPR00: 00000000 C0121CB0 C011FFF0 C1FD0060 C0121CE8 C0121D08 00000000=20
C1FD6000
GPR08: C0121D60 00000000 00000000 00000000 44000044 00020000 000C0804=20
00000000
GPR16: 00020000 FFFE21AD C0121D58 C0121D58 00000153 00000001 C1FD5D00=20
00000000
GPR24: 00000000 C0121CE8 C0121D08 C0121D08 C0121CE8 C1FB0280 00000000=20
C1FD6000
Call backtrace:
00000000 C00E900C C00BD16C C00BD280 C00C0124 C00BFC24 C00B115C
C0017684 C0003BE0 C0002B4C C00215D4 C00040A8 C00040D0 C0002418
C01317A8 C0002318
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing



--=20
vinod
S.S.S.I.H.L

------=_Part_3697_687823.1119415777992
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

thanks for the response sir.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; sir i created nodes on the dev directory using
the command mknode.Even after doing this i have problem.I do not know
if there is any problem with nfs server.But as it is seen in the
output&nbsp; on the minicom window sigseg signal occeurs then kernel
panic happens.So how can this problem be solved.<br>
<br>
I am sending the new output <br>
Welcome to minicom 2.00.0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
OPTIONS: History Buffer, F-key Macros, Search History Buffer, I18n<br>
Compiled on Jan 25 2003, 00:15:18.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
Press CTRL-A Z for help on special keys<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
405GP 1.13 ROM Monitor (4/7/00)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;--------------------- System Info ----------------------<br>
&nbsp;Processor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 405GP,&=
nbsp;&nbsp; PVR: 40110082<br>
&nbsp;Processor speed&nbsp;&nbsp; =3D 200 MHz<br>
&nbsp;PLB speed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 100 MHz=
<br>
&nbsp;OPB speed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 50 MHz<=
br>
&nbsp;Ext Bus speed&nbsp;&nbsp;&nbsp;&nbsp; =3D 50 MHz<br>
&nbsp;PCI Bus speed&nbsp;&nbsp;&nbsp;&nbsp; =3D 33 MHz (Sync)<br>
&nbsp;Amount of SDRAM&nbsp;&nbsp; =3D 32 MBytes<br>
&nbsp;Internal PCI arbiter enabled<br>
&nbsp;--------------------------------------------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;--- Device Configuration ---<br>
&nbsp;Power-On Test Devices:<br>
&nbsp;&nbsp; 000&nbsp; Disabled&nbsp; System Memory [RAM]<br>
&nbsp;&nbsp; 001&nbsp; Disabled&nbsp; Ethernet&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; [ENET]<br>
&nbsp;&nbsp; 004&nbsp; Disabled&nbsp; Serial Port 2 [S2]<br>
&nbsp;----------------------------<br>
&nbsp;Boot Sources:<br>
&nbsp;&nbsp; 001&nbsp; Enabled&nbsp;&nbsp; Ethernet&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; [ENET]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
local=3D<a href=3D"http://192.0.1.253">192.0.1.253</a>&nbsp; remote=3D<a hr=
ef=3D"http://192.0.1.50">192.0.1.50</a>&nbsp; hwaddr=3D0004ace30f38<br>
&nbsp;&nbsp; 004&nbsp; Disabled&nbsp; Serial Port 2 [S2]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
local=3D<a href=3D"http://8.1.1.2">8.1.1.2</a>&nbsp; remote=3D<a href=3D"ht=
tp://255.255.255.255">255.255.255.255</a>&nbsp; hwaddr=3Dffffffffffff<br>
&nbsp;&nbsp; 005&nbsp; Disabled&nbsp; Serial Port 1 [S1]<br>
&nbsp;----------------------------<br>
&nbsp;Debugger: Disabled<br>
&nbsp;----------------------------<br>
&nbsp; 1 - Enable/disable tests<br>
&nbsp; 2 - Enable/disable boot devices<br>
&nbsp; 3 - Change IP addresses<br>
&nbsp; 4 - Ping test<br>
&nbsp; 5 - Toggle ROM monitor debugger<br>
&nbsp; 6 - Toggle automatic menu<br>
&nbsp; 7 - Display configuration<br>
&nbsp; 8 - Save changes to configuration<br>
&nbsp; 9 - Set baud rate for s1 boot<br>
&nbsp; A - Enable/disable I cache (Enabled )<br>
&nbsp; B - Enable/disable D cache (Disabled)<br>
&nbsp; 0 - Exit menu and continue<br>
-&gt;0<br>
ENET Speed is 100 Mbs...<br>
FULL duplex connection<br>
Booting from [ENET] Ethernet&nbsp;&nbsp;&nbsp;&nbsp; ...<br>
Sending bootp request ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
Loading file &quot;/tftpboot/zImage.treeboot&quot; ...<br>
Sending tftp boot request ...<br>
Transfer Complete ...<br>
Loaded successfully ...<br>
Entry point at 0x500000 ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00500000 0059E1F8<br>
relocated to:&nbsp; 00400000 0049E1F8<br>
board data at: 0049B128 0049B168<br>
relocated to:&nbsp; 00405470 004054B0<br>
zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 004059AC 0049A376<br>
avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 0049F000 02000000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
Linux/PPC load: root=3D/dev/nfs rw ip=3Don<br>
Uncompressing Linux...done.<br>
Now booting the kernel<br>
Linux version 2.4.18_mvl30-405ep_eval (root@sairam) (gcc version 3.2.1 2002=
09305IBM Walnut (IBM405GP) Platform<br>
Port by MontaVista Software, Inc. (<a href=3D"mailto:source@mvista.com">sou=
rce@mvista.com</a>)<br>
On node 0 totalpages: 8192<br>
zone(0): 8192 pages.<br>
zone(1): 0 pages.<br>
zone(2): 0 pages.<br>
Kernel command line: root=3D/dev/nfs rw ip=3Don<br>
Calibrating delay loop... 199.47 BogoMIPS<br>
Memory: 30800k available (1024k kernel code, 332k data, 72k init, 0k highme=
m)<br>
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)<br>
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)<br>
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<br>
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)<br>
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
POSIX conformance testing by UNIFIX<br>
PCI: Probing PCI hardware<br>
Linux NET4.0 for Linux 2.4<br>
Based upon Swansea University Computer Society NET3.039<br>
Initializing RT netlink socket<br>
OCP uart ver 1.2.1 init complete<br>
Starting kswapd<br>
Disabling the Out Of Memory Killer<br>
i2c-core.o: i2c core module version 2.6.2 (20011118)<br>
initialize_kbd: Keyboard reset failed, no ACK<br>
Detected PS/2 Mouse Port.<br>
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI edttyS00 at 0xef600300 (irq =3D 0) is a 16550A<br>
ttyS01 at 0xef600400 (irq =3D 1) is a 16550A<br>
block: 64 slots per queue, batch=3D16<br>
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize<br>
loop: loaded (max 8 devices)<br>
eth0: Phy @ 0x1, type DP83843 (0x20005c10)<br>
Reset ethernet interfaces<br>
NET4: Linux TCP/IP 1.0 for NET4.0<br>
IP Protocols: ICMP, UDP, TCP, IGMP<br>
IP: routing cache hash table of 512 buckets, 4Kbytes<br>
TCP: Hash tables configured (established 2048 bind 4096)<br>
opening eth0 on emac 0<br>
eth0: IBM EMAC: link up, 100 Mbps Full Duplex, auto-negotiation complete.<b=
r>
eth0: IBM EMAC: MAC 00:04:ac:e3:0f:38.<br>
eth0: IBM EMAC: open completed<br>
Sending BOOTP and RARP requests . OK<br>
IP-Config: Got BOOTP answer from <a href=3D"http://192.0.1.50">192.0.1.50</=
a>, my address is <a href=3D"http://192.0.1.253">192.0.1.253</a><br>
IP-Config: Complete:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, addr=3D<a href=3D"http://192.=
0.1.253">192.0.1.253</a>, mask=3D<a href=3D"http://255.255.255.0">255.255.2=
55.0</a>, gw=3D<a href=3D"http://255.255.255.255">255.255.255.255</a>,<br>
&nbsp;&nbsp;&nbsp;&nbsp; host=3D<a href=3D"http://192.0.1.253">192.0.1.253<=
/a>, domain=3D, nis-domain=3D(none),<br>
&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D<a href=3D"http://192.0.1.50">192.0.1=
.50</a>, rootserver=3D<a href=3D"http://192.0.1.50">192.0.1.50</a>, rootpat=
h=3D/home/vinod/target<br>
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.<br>
Looking up port of RPC 100003/2 on <a href=3D"http://192.0.1.50">192.0.1.50=
</a><br>
Looking up port of RPC 100005/1 on <a href=3D"http://192.0.1.50">192.0.1.50=
</a><br>
VFS: Mounted root (nfs filesystem).<br>
Freeing unused kernel memory: 72k init<br>
Oops: kernel access of bad area, sig: 11<br>
NIP: C00EB22C XER: 00000000 LR: C00E900C SP: C0121CB0 REGS: c0121bf0 TRAP: =
0800dMSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11<br>
DEAR: 00000000, ESR: 00000000<br>
TASK =3D c011fff0[0] 'swapper' Last syscall: 120<br>
last math 00000000 last altivec 00000000<br>
PLB0: bear=3D 0x10000000 acr=3D&nbsp;&nbsp; 0x00000000 besr=3D&nbsp; 0x0000=
0000<br>
PLB0 to OPB: bear=3D 0x00001024 besr0=3D 0x00000000 besr1=3D 0x00000000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
<br>
GPR00: 00000000 C0121CB0 C011FFF0 C1FD0060 C0121CE8 C0121D08 00000000 C1FD6=
000<br>
GPR08: C0121D60 00000000 00000000 00000000 44000044 00020000 000C0804 00000=
000<br>
GPR16: 00020000 FFFE21AD C0121D58 C0121D58 00000153 00000001 C1FD5D00 00000=
000<br>
GPR24: 00000000 C0121CE8 C0121D08 C0121D08 C0121CE8 C1FB0280 00000000 C1FD6=
000<br>
Call backtrace:<br>
00000000 C00E900C C00BD16C C00BD280 C00C0124 C00BFC24 C00B115C<br>
C0017684 C0003BE0 C0002B4C C00215D4 C00040A8 C00040D0 C0002418<br>
C01317A8 C0002318<br>
Kernel panic: Aiee, killing interrupt handler!<br>
In interrupt handler - not syncing<br>
<br>
<br><br>-- <br>vinod<br>S.S.S.I.H.L<br>

------=_Part_3697_687823.1119415777992--
