Return-Path: <jose.annamuro@ESTUDIANTE.UAM.ES>
Message-ID: <001101c88f79$17da5ae0$7738f496@JoseLuisAM>
From: =?iso-8859-1?Q?Jos=E9_Luis_A=F1amuro_Machicao?=
	<jose.annamuro@ESTUDIANTE.UAM.ES>
To: <Linuxppc-embedded@ozlabs.org>
Subject: Cannot open root device "xsysace/disco0/part3" or 00:00
Date: Wed, 26 Mar 2008 20:39:17 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000E_01C88F81.7660FD00"
Cc: jose_luis@fun-humanismo-ciencia.es
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_000E_01C88F81.7660FD00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi
I am installing the linux kernel 2.4.26 in the FPGA Virtex II Pro =
following the instruction of=20
http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml

I compiled the linux kernel successfully, after that I build the root =
file system using the BusyBox 1.1.0 infrastructure. I configured the =
busybox and the kernel with the cross compiler, finally I execute the =
mkrootfs.sh script and obtain the all files of fyle system, these files =
I copied to ext3 partition of CompacFlash when I probe operati=F3n by =
the hyperTerminal (38400 bps) appears a error that say:

Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xfdfff003 (irq =3D 30) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
VFS: Cannot open root device "xsysace/disco0/part3" or 00:00
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00
 <0>Rebooting in 180 seconds.


I configured the linux kernel with:

Code maturity level options --->=20

            [*] Prompt for development and/or incomplete code/drivers=20

File systems --->=20

    [*] /dev file system support (EXPERIMENTAL)=20

     [*] Automatically mount at boot=20

    [*] Virtual memory file system support (former shm fs)=20

    [*] /proc file system support=20

General Setup --->=20

    [*] Networking support=20

    [*] Sysctl support=20

    [*] System V IPC=20



and edit the /etc/fstab=20

tmpfs /dev/shm tmpfs nodev,nosuid,noexec 0 0=20

proc /proc proc defaults 0 0

/dev/root / auto defaults,errors=3Dremount-ro 0 0=20



-------------------------------------------------------------------------=
------------
__    _        __  __      Jos=E9 Luis A=F1amuro - PhD Student
\/    V  /\  |\_\ /\_\      Dept. Ingenier=EDa Inform=E1tica
| |     |  /  \  | |  \/  |   |    Universidad Aut=F3noma de Madrid
| |     | / /\\ | |   |   |   |    Lab B-209   Tel. +34 615887260
| |     |/ __ \| | \  /    |    http://www.ii.uam.es/
`-_-/_/    \_\|_|\/|__|=20

------=_NextPart_000_000E_01C88F81.7660FD00
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16608" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am installing the linux kernel 2.4.26 =
in the FPGA=20
Virtex II Pro following the instruction of </FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.sh=
tml">http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml=
</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I compiled the linux kernel =
successfully, after=20
that I build the root file system using the BusyBox 1.1.0 =
infrastructure. I=20
configured the busybox and the kernel with the cross compiler, =
finally&nbsp;I=20
execute the mkrootfs.sh script and&nbsp;obtain the all files of=20
fyle&nbsp;system, these files I copied to ext3 partition of CompacFlash =
when I=20
probe&nbsp;operati=F3n by&nbsp;the hyperTerminal (38400 bps) appears a =
error that=20
say:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Serial driver version 5.05c =
(2001-07-08) with no=20
serial options enabled<BR>ttyS00 at 0xfdfff003 (irq =3D 30) is a =
16550A<BR>RAMDISK=20
driver initialized: 16 RAM disks of 4096K size 1024 blocksize<BR>VFS: =
Cannot=20
open root device "xsysace/disco0/part3" or 00:00<BR>Please append a =
correct=20
"root=3D" boot option<BR>Kernel panic: VFS: Unable to mount root fs on=20
00:00<BR>&nbsp;&lt;0&gt;Rebooting in 180 seconds.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I configured the linux kernel =
with:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>
<P align=3Dleft>Code maturity level options ---&gt; </P>
<P align=3Dleft>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
[*]=20
Prompt for development and/or incomplete code/drivers </P>
<P align=3Dleft>File systems ---&gt; </P>
<P align=3Dleft>&nbsp;&nbsp;&nbsp; [*] /dev file system support =
(EXPERIMENTAL)=20
</P>
<P align=3Dleft>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[*] Automatically mount at =
boot=20
</P><FONT size=3D3>
<P align=3Dleft>&nbsp;&nbsp;&nbsp; [*] Virtual memory file system =
support (former=20
shm fs) </P><FONT size=3D3>
<P align=3Dleft>&nbsp;&nbsp;&nbsp; [*] /proc file system support =
</P><FONT size=3D3>
<P align=3Dleft>General Setup ---&gt; </P>
<P align=3Dleft>&nbsp;&nbsp;&nbsp; [*] Networking support </P>
<P align=3Dleft>&nbsp;&nbsp;&nbsp; [*] Sysctl support </P>
<P align=3Dleft>&nbsp;&nbsp;&nbsp; [*] System V IPC </P>
<P align=3Dleft><FONT face=3DArial =
size=3D2></FONT>&nbsp;</P></FONT></FONT></FONT>
<P align=3Dleft><FONT face=3DArial>and edit the /etc/fstab =
</FONT></P><FONT=20
face=3DArial><FONT size=3D3>
<P align=3Dleft>tmpfs /dev/shm tmpfs nodev,nosuid,noexec 0 0 </P><FONT=20
face=3D"Courier New" size=3D3>
<P align=3Dleft>proc /proc proc defaults 0 0</P><FONT size=3D3>
<P align=3Dleft>/dev/root / auto defaults,errors=3Dremount-ro 0 0=20
</P></FONT></FONT></FONT></FONT>
<P align=3Dleft><FONT face=3DArial></FONT>&nbsp;</P></FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>----------------------------------------------------------------=
---------------------<BR>__&nbsp;&nbsp;&nbsp;=20
_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __&nbsp;=20
__&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jos=E9 Luis A=F1amuro - PhD=20
Student<BR>\/&nbsp;&nbsp;&nbsp; V&nbsp; /\&nbsp; |\_\=20
/\_\&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dept. Ingenier=EDa Inform=E1tica<BR>| =

|&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; /&nbsp; \&nbsp; | |&nbsp; \/&nbsp;=20
|&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; Universidad Aut=F3noma de Madrid<BR>|=20
|&nbsp;&nbsp;&nbsp;&nbsp; | / /\\ | |&nbsp;&nbsp; |&nbsp;&nbsp; =
|&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; Lab B-209&nbsp;&nbsp; Tel. +34 615887260<BR>|=20
|&nbsp;&nbsp;&nbsp;&nbsp; |/ __ \| | \&nbsp; /&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; <A=20
href=3D"http://www.ii.uam.es/">http://www.ii.uam.es/</A><BR>`-_-/_/&nbsp;=
&nbsp;&nbsp;=20
\_\|_|\/|__| <BR></FONT></DIV></BODY></HTML>

------=_NextPart_000_000E_01C88F81.7660FD00--
