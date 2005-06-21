Return-Path: <bvinodsmail@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 033A467AA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Jun 2005 18:20:05 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 55so1304190wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Jun 2005 01:20:04 -0700 (PDT)
Message-ID: <198df04d050621011328999642@mail.gmail.com>
Date: Tue, 21 Jun 2005 13:43:23 +0530
From: vinod b <bvinodsmail@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_306_16479728.1119341603766"
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

------=_Part_306_16479728.1119341603766
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am sending the output on the minicom window can some=20
body tell me what is the problem.It <http://problem.It> will be of great
 help.


Welcome to minicom 2.00.0

OPTIONS: History Buffer, F-key Macros, Search History Buffer, I18n
Compiled on Jan 25 2003, 00:15:18.

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
                  local=3D192.0.1.253 <http://192.0.1.253>=20
remote=3D192.0.1.21 <http://192.0.1.21>  hwaddr=3D0004ace30f38
   004  Disabled  Serial Port 2 [S2]
                  local=3D8.1.1.2 <http://8.1.1.2>=20
remote=3D255.255.255.255 <http://255.255.255.255>  hwaddr=3Dffffffffffff
   005  Disabled  Serial Port 1 [S1]
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
->
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
relocated to:  00405470 004054B0
zimage at:     004059AC 0049AB26
avail ram:     0049F000 02000000

Linux/PPC load: root=3D/dev/nfs rw ip=3Don
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.18_mvl30-405ep_eval (root@AUM-SAI) (gcc version
3.2.1 20020930 (MontaVista)) #1 Sun Jun 19 13:50:01 IST 25
IBM Walnut (IBM405GP) Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/nfs rw ip=3Don
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
IP-Config: Got BOOTP answer from 192.0.1.21 <http://192.0.1.21>, my
address is 192.0.1.253 <http://192.0.1.253>
IP-Config: Complete:
      device=3Deth0, addr=3D192.0.1.253 <http://192.0.1.253>,
mask=3D255.255.255.0 <http://255.255.255.0>, gw=3D255.255.255.255
<http://255.255.255.255>,
     host=3D192.0.1.253 <http://192.0.1.253>, domain=3D, nis-domain=3D(none=
),
     bootserver=3D192.0.1.21 <http://192.0.1.21>, rootserver=3D192.0.1.21
<http://192.0.1.21>, rootpath=3D/home/walnut/target
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.0.1.21 <http://192.0.1.21>
Looking up port of RPC 100005/1 on 192.0.1.21 <http://192.0.1.21>
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 72k init
Warning: unable to open an initial console.
nfs: server 192.0.1.21 <http://192.0.1.21> not responding, still trying

nfs: server 192.0.1.21 <http://192.0.1.21> OK
Oops: kernel access of bad area, sig: 11
NIP: C0004A48 XER: 00000000 LR: C000DC98 SP: C1FEF590 REGS: c1fef4d0
TRAP: 0800    Not tainted
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DEAR: 00000000, ESR: 00000000
TASK =3D c1fee000[1] 'swapper' Last syscall: 11
last math 00000000 last altivec 00000000
PLB0: bear=3D 0x10000000 acr=3D   0x00000000 besr=3D  0x00000000
PLB0 to OPB: bear=3D 0x119a3470 besr0=3D 0x00000000 besr1=3D 0x00000000

GPR00: C00A081C C1FEF590 C1FEE000 00000000 00000005 0000001F 00000000 C1FCD=
260
GPR08: 00000002 C1FD3158 C1FCD2D8 C1FD302C 00784263 00000000 00000003 00000=
000
GPR16: 00000000 FFFE21AD 00000000 C1FCD460 00000002 C1FCD480 00000000 00000=
000
GPR24: C00E00A4 C1FEF6E8 C3004800 00000000 00000000 C1FD3000 00000000 00000=
09A
Call backtrace:
C0000000 C00A081C C00B894C C00B1410 C00B5EB0 C00C45D0 C00C32E0
C00C3D8C C00E0404 C00E7724 C00A96FC C00F4518 C00F373C C00F36C4
C00F1794 C00F5AA4 C00F5D5C C00F0EF4 C006B944 C00657DC C0042744
C0042C6C C0042FE8 C0040060 C0055D98 C00409EC C0040C14 C0005644
C00028FC C0002708 C0004E6C
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..<NULL>
=20

Thanking you all.......
--=20
vinod

------=_Part_306_16479728.1119341603766
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<pre style=3D"font-weight: bold;"><font size=3D"4">I am sending the output =
on the minicom window can some <br>body tell me what is the <a href=3D"http=
://problem.It">problem.It</a> will be of great<br>&nbsp;help.<br><br><br>We=
lcome to minicom=20
2.00.0<br><br>OPTIONS: History Buffer, F-key Macros, Search History Buffer,=
 I18n<br>Compiled on Jan 25 2003, 00:15:18.<br><br>Press CTRL-A Z for help =
on special keys<br><br><br><br>405GP 1.13 ROM Monitor (4/7/00)<br><br> ----=
----------------- System Info ----------------------
<br> Processor         =3D 405GP,   PVR: 40110082<br> Processor speed   =3D=
 200 MHz<br> PLB speed         =3D 100 MHz<br> OPB speed         =3D 50 MHz=
<br> Ext Bus speed     =3D 50 MHz<br> PCI Bus speed     =3D 33 MHz (Sync)<b=
r> Amount of SDRAM   =3D 32 MBytes
<br> Internal PCI arbiter enabled<br> -------------------------------------=
-------------------<br><br> --- Device Configuration ---<br> Power-On Test =
Devices:<br>   000  Disabled  System Memory [RAM]<br>   001  Disabled  Ethe=
rnet      [ENET]
<br>   004  Disabled  Serial Port 2 [S2]<br> ----------------------------<b=
r> Boot Sources:<br>   001  Enabled   Ethernet      [ENET]<br>             =
     local=3D<a href=3D"http://192.0.1.253">192.0.1.253</a>  remote=3D<a hr=
ef=3D"http://192.0.1.21">
192.0.1.21</a>  hwaddr=3D0004ace30f38<br>   004  Disabled  Serial Port 2 [S=
2]<br>                  local=3D<a href=3D"http://8.1.1.2">8.1.1.2</a>  rem=
ote=3D<a href=3D"http://255.255.255.255">255.255.255.255</a>  hwaddr=3Dffff=
ffffffff
<br>   005  Disabled  Serial Port 1 [S1]<br> ----------------------------<b=
r> Debugger: Disabled<br> ----------------------------<br>  1 - Enable/disa=
ble tests<br>  2 - Enable/disable boot devices<br>  3 - Change IP addresses
<br>  4 - Ping test<br>  5 - Toggle ROM monitor debugger<br>  6 - Toggle au=
tomatic menu<br>  7 - Display configuration<br>  8 - Save changes to config=
uration<br>  9 - Set baud rate for s1 boot<br>  A - Enable/disable I cache =
(Enabled )
<br>  B - Enable/disable D cache (Disabled)<br>  0 - Exit menu and continue=
<br>-&gt;<br> 1 - Enable/disable tests<br>  2 - Enable/disable boot devices=
<br>  3 - Change IP addresses<br>  4 - Ping test<br>  5 - Toggle ROM monito=
r debugger
<br>  6 - Toggle automatic menu<br>  7 - Display configuration<br>  8 - Sav=
e changes to configuration<br>  9 - Set baud rate for s1 boot<br>  A - Enab=
le/disable I cache (Enabled )<br>  B - Enable/disable D cache (Disabled)
<br>  0 - Exit menu and continue<br>-&gt;0<br>ENET Speed is 100 Mbs...<br>F=
ULL duplex connection<br>Booting from [ENET] Ethernet     ...<br>Sending bo=
otp request ...<br><br><br>Loading file &quot;/tftpboot/zImage.treeboot&quo=
t; ...
<br>Sending tftp boot request ...<br>Transfer Complete ...<br>Loaded succes=
sfully ...<br>Entry point at 0x500000 ...<br><br>loaded at:     00500000 00=
59E1F8<br>relocated to:  00400000 0049E1F8<br>board data at: 0049B128 0049B=
168
<br>relocated to:  00405470 004054B0<br>zimage at:     004059AC 0049AB26<br=
>avail ram:     0049F000 02000000<br><br>Linux/PPC load: root=3D/dev/nfs rw=
 ip=3Don<br>Uncompressing Linux...done.<br>Now booting the kernel<br>Linux =
version=20
2.4.18_mvl30-405ep_eval (root@AUM-SAI) (gcc version 3.2.1 20020930 (MontaVi=
sta)) #1 Sun Jun 19 13:50:01 IST 25<br>IBM Walnut (IBM405GP) Platform<br>Po=
rt by MontaVista Software, Inc. (<a href=3D"mailto:source@mvista.com">sourc=
e@mvista.com
</a>)<br>On node 0 totalpages: 8192<br>zone(0): 8192 pages.<br>zone(1): 0 p=
ages.<br>zone(2): 0 pages.<br>Kernel command line: root=3D/dev/nfs rw ip=3D=
on<br>Calibrating delay loop... 199.47 BogoMIPS<br>Memory: 30788k available=
 (1024k kernel code, 344k data, 72k init, 0k highmem)
<br>Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)<br>Inode-=
cache hash table entries: 2048 (order: 2, 16384 bytes)<br>Mount-cache hash =
table entries: 512 (order: 0, 4096 bytes)<br>Buffer-cache hash table entrie=
s: 1024 (order: 0, 4096 bytes)
<br>Page-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>POSIX co=
nformance testing by UNIFIX<br>PCI: Probing PCI hardware<br>Linux NET4.0 fo=
r Linux 2.4<br>Based upon Swansea University Computer Society NET3.039<br>
Initializing RT netlink socket<br>OCP uart ver 1.2.1 init complete<br>Start=
ing kswapd<br>Disabling the Out Of Memory Killer<br>i2c-core.o: i2c core mo=
dule version 2.6.2 (20011118)<br>initialize_kbd: Keyboard reset failed, no =
ACK
<br>Detected PS/2 Mouse Port.<br>pty: 256 Unix98 ptys configured<br>Serial =
driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enab=
led<br>ttyS00 at 0xef600300 (irq =3D 0) is a 16550A<br>ttyS01 at 0xef600400=
 (irq =3D 1) is a 16550A
<br>block: 64 slots per queue, batch=3D16<br>RAMDISK driver initialized: 16=
 RAM disks of 4096K size 1024 blocksize<br>loop: loaded (max 8 devices)<br>=
eth0: Phy @ 0x1, type DP83843 (0x20005c10)<br>Reset ethernet interfaces<br>
NET4: Linux TCP/IP 1.0 for NET4.0<br>IP Protocols: ICMP, UDP, TCP, IGMP<br>=
IP: routing cache hash table of 512 buckets, 4Kbytes<br>TCP: Hash tables co=
nfigured (established 2048 bind 4096)<br>opening eth0 on emac 0<br>eth0: IB=
M EMAC: link up, 100 Mbps Full Duplex, auto-negotiation complete.
<br>eth0: IBM EMAC: MAC 00:04:ac:e3:0f:38.<br>eth0: IBM EMAC: open complete=
d<br>Sending BOOTP and RARP requests . OK<br>IP-Config: Got BOOTP answer fr=
om <a href=3D"http://192.0.1.21">192.0.1.21</a>, my address is <a href=3D"h=
ttp://192.0.1.253">
192.0.1.253</a><br>IP-Config: Complete:<br>      device=3Deth0, addr=3D<a h=
ref=3D"http://192.0.1.253">192.0.1.253</a>, mask=3D<a href=3D"http://255.25=
5.255.0">255.255.255.0</a>, gw=3D<a href=3D"http://255.255.255.255">255.255=
.255.255</a>
,<br>     host=3D<a href=3D"http://192.0.1.253">192.0.1.253</a>, domain=3D,=
 nis-domain=3D(none),<br>     bootserver=3D<a href=3D"http://192.0.1.21">19=
2.0.1.21</a>, rootserver=3D<a href=3D"http://192.0.1.21">192.0.1.21</a>, ro=
otpath=3D/home/walnut/target
<br>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.<br>Looking up port =
of RPC 100003/2 on <a href=3D"http://192.0.1.21">192.0.1.21</a><br>Looking =
up port of RPC 100005/1 on <a href=3D"http://192.0.1.21">192.0.1.21</a><br>
VFS: Mounted root (nfs filesystem).<br>Freeing unused kernel memory: 72k in=
it<br>Warning: unable to open an initial console.<br>nfs: server <a href=3D=
"http://192.0.1.21">192.0.1.21</a> not responding, still trying<br><br>nfs:=
 server=20
<a href=3D"http://192.0.1.21">192.0.1.21</a> OK<br>Oops: kernel access of b=
ad area, sig: 11<br>NIP: C0004A48 XER: 00000000 LR: C000DC98 SP: C1FEF590 R=
EGS: c1fef4d0 TRAP: 0800    Not tainted<br>MSR: 00001030 EE: 0 PR: 0 FP: 0 =
ME: 1 IR/DR: 11
<br>DEAR: 00000000, ESR: 00000000<br>TASK =3D c1fee000[1] 'swapper' Last sy=
scall: 11<br>last math 00000000 last altivec 00000000<br>PLB0: bear=3D 0x10=
000000 acr=3D   0x00000000 besr=3D  0x00000000<br>PLB0 to OPB: bear=3D 0x11=
9a3470 besr0=3D 0x00000000 besr1=3D 0x00000000
<br><br>GPR00: C00A081C C1FEF590 C1FEE000 00000000 00000005 0000001F 000000=
00 C1FCD260<br>GPR08: 00000002 C1FD3158 C1FCD2D8 C1FD302C 00784263 00000000=
 00000003 00000000<br>GPR16: 00000000 FFFE21AD 00000000 C1FCD460 00000002 C=
1FCD480 00000000 00000000
<br>GPR24: C00E00A4 C1FEF6E8 C3004800 00000000 00000000 C1FD3000 00000000 0=
000009A<br>Call backtrace:<br>C0000000 C00A081C C00B894C C00B1410 C00B5EB0 =
C00C45D0 C00C32E0<br>C00C3D8C C00E0404 C00E7724 C00A96FC C00F4518 C00F373C =
C00F36C4
<br>C00F1794 C00F5AA4 C00F5D5C C00F0EF4 C006B944 C00657DC C0042744<br>C0042=
C6C C0042FE8 C0040060 C0055D98 C00409EC C0040C14 C0005644<br>C00028FC C0002=
708 C0004E6C<br>Kernel panic: Aiee, killing interrupt handler!<br>In interr=
upt handler - not syncing
<br> &lt;0&gt;Rebooting in 180 seconds..&lt;NULL&gt;<br> </font></pre>
<font size=3D"4"><br style=3D"font-weight: bold;">
Thanking you all.......<br style=3D"font-weight: bold;">
<span style=3D"font-weight: bold;">-- </span><br style=3D"font-weight: bold=
;">
<span style=3D"font-weight: bold;">vinod</span><br style=3D"font-weight: bo=
ld;">
<span style=3D"font-weight: bold;"></span><br style=3D"font-weight: bold;">
</font>

------=_Part_306_16479728.1119341603766--
