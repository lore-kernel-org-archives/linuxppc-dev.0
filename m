Return-Path: <d.flament@sofrel.com>
Received: from smtp9.clb.oleane.net (smtp9.clb.oleane.net [213.56.31.31])
	by ozlabs.org (Postfix) with ESMTP id B1EAA67BEF
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 18:05:45 +1000 (EST)
Received: from smtp9.clb.oleane.net (localhost [127.0.0.1])
	by smtp9.clb.oleane.net (antivirus) with ESMTP id j6C85gs7004717
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 10:05:42 +0200
Received: from sof_msg.sofrel.local ([81.80.115.55])
	by smtp9.clb.oleane.net with ESMTP id j6C85f6Q004693
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 10:05:41 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C586B8.CD1AB848"
Date: Tue, 12 Jul 2005 10:07:52 +0200
Message-ID: <892C3EC180087B4498C69413FCCBB7320159ADF0@sof_msg>
From: "FLAMENT David" <d.flament@sofrel.com>
To: <linuxppc-dev@ozlabs.org>
Subject: help me for: Oops: kernel access of bad area,
	sig: 11 on rattler 8248 (ppc)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C586B8.CD1AB848
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear,

    Here is my problems,

    OS: kernel 2.4.26
    platform: ppc rattler 8248


When we activate MPC82xxPCI in general setup of kernel config the =
following massages is printed :

Rattler Board Support by Arabella
Memory BAT mapping: BAT2=3D32Mb, BAT3=3D0Mb, residual: 0Mb
Linux version 2.4.26 (root@linux1.besoft.sofrel.com) (version gcc 3.2.2 =
20030217 (Yellow Dog Linux 3.0 3.5Rattler setup arch
rattler_setup_arch: bcsr=3Deffff000
MPC82xx PCI bridge initialization
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: nfsroot=3D/tftpboot/ppc_root rw =
ip=3D192.168.1.23:192.168.1.21::::eth0:off
Rattler init IRQ. NR_IRQS=3D256
PIC: fully preemptible IRQ mode
Rattler time init
Rattler calibrate decrementer. FREQ=3D100000000, =
tb_ticks_per_jiffy=3D250000
Calibrating delay loop... 266.24 BogoMIPS
Memory: 30256k available (1488k kernel code, 520k data, 76k init, 0k =
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Oops: kernel access of bad area, sig: 11
NIP: C01D3888 XER: 00000000 LR: C01D3880 SP: C02F1F50 REGS: c02f1ea0 =
TRAP: 0300 Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000080, DSISR: 22000000
TASK =3D c02f0000[1] 'swapper' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: C01D3870 C02F1F50 C02F0000 F0000000 000018C1 C02F1F58 FFFFFFFF =
00000000
GPR08: FFFFC4BA 1FFF0000 C01BB85B 00001057 22008022 3FDFF7AF 01FFE000 =
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 003FF000 00000000 00000002 =
01BCA298
GPR24: 00000000 00000000 40000000 007FFF46 00000000 00000000 C01E0000 =
C01DB88C
Call backtrace:
C01D3870 C01C9474 C01D0CEC C01C66DC C0003970 C00083AC
Kernel panic: Attempted to kill init!
=20
=20
thanks for your suggest !
=20
--------------------------------
Flament David
d.flament@sofrel.com
Lacroix Sofrel, 1 rue plessis, 35770 Vern sur seiche (France)
(+33)2.99.04.84.23
=20
=20

------_=_NextPart_001_01C586B8.CD1AB848
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<P><FONT face=3DArial size=3D2>Dear,<BR><BR>&nbsp;&nbsp;&nbsp; Here is =
my=20
problems,<BR><BR>&nbsp;&nbsp;&nbsp; OS:&nbsp;<SPAN=20
class=3D154355807-12072005>kernel 2.4.26</SPAN><BR>&nbsp;&nbsp;&nbsp; =
platform:=20
ppc&nbsp;<SPAN class=3D154355807-12072005>rattler =
8248</SPAN><BR></FONT><FONT=20
face=3DArial><SPAN class=3D154355807-12072005></SPAN></FONT></P>
<P><FONT face=3DArial><SPAN class=3D154355807-12072005>When we activate =
MPC82xxPCI=20
in general setup of kernel config the following massages is printed=20
:</SPAN></FONT></P></DIV>
<DIV><FONT face=3DArial size=3D2>Rattler Board Support by =
Arabella</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Memory BAT mapping: BAT2=3D32Mb, =
BAT3=3D0Mb, residual:=20
0Mb</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Linux version 2.4.26=20
(root@linux1.besoft.sofrel.com) (version gcc 3.2.2 20030217 (Yellow Dog =
Linux=20
3.0 3.5Rattler setup arch</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>rattler_setup_arch: =
bcsr=3Deffff000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>MPC82xx PCI bridge =
initialization</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>On node 0 totalpages: 8192</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>zone(0): 8192 pages.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>zone(1): 0 pages.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>zone(2): 0 pages.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Kernel command line: =
nfsroot=3D/tftpboot/ppc_root rw=20
ip=3D192.168.1.23:192.168.1.21::::eth0:off</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Rattler init IRQ. =
NR_IRQS=3D256</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PIC: fully preemptible IRQ =
mode</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Rattler time init</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Rattler calibrate decrementer. =
FREQ=3D100000000,=20
tb_ticks_per_jiffy=3D250000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Calibrating delay loop... 266.24=20
BogoMIPS</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Memory: 30256k available (1488k kernel =
code, 520k=20
data, 76k init, 0k highmem)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Dentry cache hash table entries: 4096 =
(order: 3,=20
32768 bytes)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Inode cache hash table entries: 2048 =
(order: 2,=20
16384 bytes)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Mount cache hash table entries: 512 =
(order: 0, 4096=20
bytes)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Buffer cache hash table entries: 1024 =
(order: 0,=20
4096 bytes)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Page-cache hash table entries: 8192 =
(order: 3,=20
32768 bytes)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>POSIX conformance testing by =
UNIFIX</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>PCI: Probing PCI hardware</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Oops: kernel access of bad area, sig:=20
11</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>NIP: C01D3888 XER: 00000000 LR: =
C01D3880 SP:=20
C02F1F50 REGS: c02f1ea0 TRAP: 0300 Not tainted</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 =
IR/DR:=20
11</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>DAR: 00000080, DSISR: =
22000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>TASK =3D c02f0000[1] 'swapper' Last =
syscall:=20
-1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>last math 00000000 last altivec=20
00000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>GPR00: C01D3870 C02F1F50 C02F0000 =
F0000000 000018C1=20
C02F1F58 FFFFFFFF 00000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>GPR08: FFFFC4BA 1FFF0000 C01BB85B =
00001057 22008022=20
3FDFF7AF 01FFE000 00000000</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>GPR16: 00000001 00000001 FFFFFFFF =
007FFF00 003FF000=20
00000000 00000002 01BCA298</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>GPR24: 00000000 00000000 40000000 =
007FFF46 00000000=20
00000000 C01E0000 C01DB88C</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Call backtrace:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>C01D3870 C01C9474 C01D0CEC C01C66DC =
C0003970=20
C00083AC</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Kernel panic: Attempted to kill =
init!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D154355807-12072005>thanks =
for your=20
suggest !</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D154355807-12072005></SPAN></FONT><FONT=20
face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>--------------------------------</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Flament David</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"mailto:d.flament@sofrel.com">d.flament@sofrel.com</A></FONT></DIV=
>
<DIV><FONT face=3DArial size=3D2>Lacroix Sofrel, </FONT><FONT =
face=3DArial size=3D2>1=20
rue plessis, 35770 Vern sur seiche (France)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>(+33)2.99.04.84.23</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C586B8.CD1AB848--
